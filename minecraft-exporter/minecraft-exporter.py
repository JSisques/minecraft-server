from src.metrics.file_metrics import file_count_gauge, folder_count_gauge, total_size_gauge, average_file_size_gauge, json_file_count_gauge, dat_file_count_gauge
from src.metrics.disk_metrics import free_disk_space_gauge, total_disk_space_gauge, get_disk_usage
from src.utils.server_properties import parse_server_properties, update_server_properties_metrics
from src.utils.user_advancements import update_user_advancements
from src.metrics.user_metrics import update_user_metrics
from src.utils.file_utils import collect_directory_metrics
from src.utils.logging_config import setup_logging
from src.utils.forge_info import update_forge_info

from prometheus_client import start_http_server

import argparse
import logging
import time
import os


def collect_metrics(directory, interval):
    """Función para recoger y actualizar las métricas."""
    while True:
        try:
            file_count, folder_count, total_size, average_size, json_file_count, dat_file_count = collect_directory_metrics(directory)
            free_space, total_space = get_disk_usage(directory)

            # Actualizar las métricas
            file_count_gauge.set(file_count)
            folder_count_gauge.set(folder_count)
            total_size_gauge.set(total_size)
            average_file_size_gauge.set(average_size)
            free_disk_space_gauge.set(free_space)
            total_disk_space_gauge.set(total_space)
            json_file_count_gauge.set(json_file_count)
            dat_file_count_gauge.set(dat_file_count)

            # Leer y actualizar métricas de usuarios
            ops_json_path = os.path.join(directory, 'ops.json')
            update_user_metrics(ops_json_path)
            
            # Leer y actualizar métricas de avances
            advancements_directory = os.path.join(directory, 'world', 'advancements')
            update_user_advancements(advancements_directory)
            
            # Actualizar métricas de Forge
            manifest_path = os.path.join(directory, '.neoforge-manifest.json')
            update_forge_info(manifest_path)
            
            # Actualizar métricas de propiedades del servidor
            server_properties_path = os.path.join(directory, 'server.properties')
            properties = parse_server_properties(server_properties_path)
            update_server_properties_metrics(properties)

            logging.info(f'Updated metrics: Files: {file_count}, Folders: {folder_count}, Total Size: {total_size}, Average File Size: {average_size}, Free Space: {free_space}, Total Space: {total_space}, JSON Files: {json_file_count}, DAT Files: {dat_file_count}')

        except Exception as e:
            logging.error(f'Error collecting metrics: {e}')

        # Esperar el intervalo de tiempo antes de la próxima actualización
        time.sleep(interval)

if __name__ == '__main__':
    setup_logging()

    # Configurar el parser de argumentos
    parser = argparse.ArgumentParser(description='Exporter para monitorizar un directorio.')
    parser.add_argument('-f', '--directory', type=str, required=True, help='Directorio a monitorizar')
    parser.add_argument('-i', '--interval', type=int, required=True, help='Intervalo de tiempo en segundos')
    
    # Parsear los argumentos
    args = parser.parse_args()
    directory_to_monitor = args.directory
    interval = args.interval

    # Verificar que el directorio existe
    if not os.path.isdir(directory_to_monitor):
        raise ValueError(f"El directorio {directory_to_monitor} no existe o no es un directorio válido.")

    # Iniciar el servidor HTTP en el puerto 8000
    logging.info('Starting HTTP server on port 8000')
    start_http_server(8000)
    
    # Comenzar a recoger métricas
    collect_metrics(directory_to_monitor, interval)
