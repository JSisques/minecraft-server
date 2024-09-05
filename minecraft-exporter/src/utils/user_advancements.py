# src/utils/user_advancements.py

import os
import json
import time
import logging
from src.metrics.user_advancements_metrics import advancement_criteria_gauge, advancement_done_gauge

def update_user_advancements(advancements_directory):
    """Actualiza las métricas de avances basadas en los archivos JSON en el directorio especificado."""
    if not os.path.isdir(advancements_directory):
        logging.warning(f"No se encontró el directorio de avances en {advancements_directory}")
        return

    try:
        # Limpiar métricas anteriores
        advancement_criteria_gauge.clear()
        advancement_done_gauge.clear()

        for filename in os.listdir(advancements_directory):
            if filename.endswith('.json'):
                player_uuid = filename.replace('.json', '')
                file_path = os.path.join(advancements_directory, filename)

                with open(file_path, 'r') as f:
                    data = json.load(f)

                # Procesar los datos para las categorías de avances
                for advancement, details in data.items():
                    criteria = details.get("criteria", {})
                    done = details.get("done", False)

                    # Actualizar las métricas para cada criterio
                    for key, value in criteria.items():
                        # Convertir la fecha en timestamp para la métrica
                        try:
                            timestamp = int(time.mktime(time.strptime(value, "%Y-%m-%d %H:%M:%S +0000")))
                        except ValueError:
                            logging.warning(f'Fecha con formato inválido: {value}')
                            continue
                        advancement_criteria_gauge.labels(player=player_uuid, advancement=advancement, criteria=key).set(timestamp)

                    # Actualizar métrica para el estado del avance
                    advancement_done_gauge.labels(player=player_uuid, advancement=advancement).set(1 if done else 0)

    except Exception as e:
        logging.error(f'Error procesando los archivos de avances: {e}')
