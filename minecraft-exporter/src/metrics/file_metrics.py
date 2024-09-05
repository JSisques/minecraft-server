from prometheus_client import Gauge

# Crear métricas tipo Gauge para archivos
file_count_gauge = Gauge('data_directory_file_count', 'Número de archivos en el directorio monitorizado')
folder_count_gauge = Gauge('data_directory_folder_count', 'Número de carpetas en el directorio monitorizado')
total_size_gauge = Gauge('data_directory_total_size_bytes', 'Tamaño total de los archivos en el directorio monitorizado (bytes)')
average_file_size_gauge = Gauge('data_directory_average_file_size_bytes', 'Tamaño promedio de los archivos en el directorio monitorizado (bytes)')
json_file_count_gauge = Gauge('data_directory_json_file_count', 'Número de archivos JSON en el directorio monitorizado')
dat_file_count_gauge = Gauge('data_directory_dat_file_count', 'Número de archivos DAT en el directorio monitorizado')
