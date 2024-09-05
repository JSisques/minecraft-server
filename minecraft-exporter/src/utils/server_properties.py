# src/metrics/server_properties_metrics.py
from src.metrics.server_properties_metrics import server_property_info

import logging

def parse_server_properties(file_path):
    """Parsea el archivo server.properties y devuelve un diccionario de propiedades."""
    properties = {}
    try:
        with open(file_path, 'r') as f:
            for line in f:
                # Ignorar comentarios y líneas vacías
                if line.startswith('#') or not line.strip():
                    continue
                # Dividir en clave y valor
                if '=' in line:
                    key, value = line.split('=', 1)
                    key = key.strip()
                    value = value.strip()
                    properties[key] = value
    except FileNotFoundError:
        logging.error(f'Archivo no encontrado: {file_path}')
    except IOError as e:
        logging.error(f'Error de I/O leyendo el archivo {file_path}: {e}')
    except Exception as e:
        logging.error(f'Error desconocido leyendo el archivo {file_path}: {e}')
    return properties

def update_server_properties_metrics(properties):
    """Actualiza las métricas de propiedades del servidor con los datos proporcionados."""
    # Actualizar métricas basadas en las propiedades del servidor
    for key, value in properties.items():
        # Convertir el valor a un tipo adecuado para Prometheus (solo números flotantes o enteros)
        try:
            # Intentar convertir a un número flotante o entero
            numeric_value = float(value)
            if numeric_value.is_integer():
                server_property_info.labels(property=key).info({'value': value})
            else:
                server_property_info.labels(property=key).info({'value': value})
        except ValueError:
            # Para valores no numéricos, registrar el valor como una etiqueta
            # Usar un valor de 1 para indicar que la propiedad está presente
            server_property_info.labels(property=key).info({'value': value})
            logging.info(f'Propiedad no numérica encontrada: {key} = {value}')
