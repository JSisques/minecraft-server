import logging

def setup_logging():
    """Configura el logging."""
    logging.basicConfig(level=logging.CRITICAL, format='%(asctime)s - %(levelname)s - %(message)s')
