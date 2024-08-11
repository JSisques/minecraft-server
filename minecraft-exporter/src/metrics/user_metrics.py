from prometheus_client import Info, Gauge
import json
import os
import logging

# Crear métricas tipo Info y Gauge para usuarios
user_uuid_gauge = Info('user_uuid', 'UUID del usuario', ['user'])
user_level_gauge = Gauge('user_level', 'Nivel del usuario', ['user'])
user_bypasses_gauge = Gauge('user_bypassesPlayerLimit', '¿El usuario omite el límite de jugadores?', ['user'])

def update_user_metrics(ops_json_path):
    """Actualiza las métricas de usuarios basadas en los datos JSON."""
    if not os.path.isfile(ops_json_path):
        logging.warning(f"No se encontró el archivo ops.json en {ops_json_path}")
        return

    try:
        with open(ops_json_path, 'r') as f:
            users = json.load(f)
            logging.info(f'Users data: {users}')  # Asegúrate de que los datos se cargan correctamente

        # Limpiar métricas anteriores
        user_uuid_gauge.clear()
        user_level_gauge.clear()
        user_bypasses_gauge.clear()

        for user in users:
            name = user.get('name', 'unknown')
            uuid = user.get('uuid', 'unknown')
            level = user.get('level', 0)
            bypasses = user.get('bypassesPlayerLimit', False)

            # Actualizar métricas de usuarios
            user_uuid_gauge.labels(user=name).info({'uuid': uuid})
            user_level_gauge.labels(user=name).set(level)
            user_bypasses_gauge.labels(user=name).set(1 if bypasses else 0)

    except Exception as e:
        logging.error(f'Error procesando el archivo ops.json: {e}')
