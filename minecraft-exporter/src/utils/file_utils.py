import os

def collect_directory_metrics(directory):
    """Recoge y devuelve métricas sobre los archivos en el directorio."""
    file_count = folder_count = total_size = 0
    json_file_count = dat_file_count = 0

    for root, dirs, files in os.walk(directory):
        folder_count += len(dirs)
        for file in files:
            file_path = os.path.join(root, file)
            total_size += os.path.getsize(file_path)
            
            # Contar archivos JSON y DAT
            if file.endswith('.json'):
                json_file_count += 1
            elif file.endswith('.dat'):
                dat_file_count += 1

    file_count = len([name for name in os.listdir(directory) if os.path.isfile(os.path.join(directory, name))])

    # Calcular el tamaño promedio del archivo
    average_size = total_size / file_count if file_count > 0 else 0

    return file_count, folder_count, total_size, average_size, json_file_count, dat_file_count
