# src/utils/forge_info.py

import json
import os
import logging
from src.metrics.forge_metrics import minecraft_version_gauge, forge_version_gauge

def update_forge_info(manifest_path):
    """Actualiza las métricas basadas en el archivo .neoforge-manifest.json."""
    if not os.path.isfile(manifest_path):
        logging.warning(f"No se encontró el archivo de manifiesto en {manifest_path}")
        return

    try:
        with open(manifest_path, 'r') as f:
            data = json.load(f)

        # Extraer datos del archivo JSON
        minecraft_version = data.get('minecraftVersion', 'unknown')
        forge_version = data.get('forgeVersion', 'unknown')

        # Actualizar métricas
        minecraft_version_gauge.info({'version': minecraft_version})
        forge_version_gauge.info({'version': forge_version})
        

    except Exception as e:
        logging.error(f'Error procesando el archivo .neoforge-manifest.json: {e}')
