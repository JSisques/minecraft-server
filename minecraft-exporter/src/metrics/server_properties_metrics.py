# src/metrics/server_properties.py

from prometheus_client import Info

# Crear métricas de tipo Info para las propiedades del servidor
server_property_info = Info('server_property', 'Propiedades del servidor Minecraft', ['property'])