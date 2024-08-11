# src/metrics/user_advancements_metrics.py

from prometheus_client import Gauge

# Crear métricas tipo Gauge con etiquetas
advancement_criteria_gauge = Gauge(
    'player_advancement_criteria', 
    'Tiempos de avances del jugador en diferentes criterios', 
    ['player', 'advancement', 'criteria']
)
advancement_done_gauge = Gauge(
    'player_advancement_done', 
    'Estado de avance del jugador', 
    ['player', 'advancement']
)
