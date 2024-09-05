from prometheus_client import Gauge
import psutil
import os

# Crear métricas tipo Gauge para el disco
free_disk_space_gauge = Gauge('disk_free_space_bytes', 'Espacio libre en el disco (bytes)')
total_disk_space_gauge = Gauge('disk_total_space_bytes', 'Espacio total en el disco (bytes)')

def get_disk_usage(directory):
    """Obtiene el espacio libre y total en el disco dependiendo del sistema operativo."""
    if os.name == 'nt':
        disk_usage = psutil.disk_usage(directory)
        return disk_usage.free, disk_usage.total
    else:
        statvfs = os.statvfs(directory)
        return statvfs.f_frsize * statvfs.f_bavail, statvfs.f_frsize * statvfs.f_blocks
