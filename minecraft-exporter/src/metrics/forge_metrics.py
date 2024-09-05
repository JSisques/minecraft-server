# src/metrics/forge_metrics.py

from prometheus_client import Gauge, Info

# Crear métricas tipo Gauge
minecraft_version_gauge = Info(
    'minecraft_version', 
    'Versión de Minecraft en el archivo .neoforge-manifest.json'
)
forge_version_gauge = Info(
    'forge_version', 
    'Versión de Forge en el archivo .neoforge-manifest.json'
)
