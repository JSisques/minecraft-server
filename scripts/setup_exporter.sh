#!/bin/bash

# Variables - Ajusta estas rutas y valores según tus necesidades
SCRIPT_PATH="/home/javi/minecraft-server/minecraft-exporter/minecraft-exporter.py"
MONITORING_DIRECTORY="/home/javi/minecraft-server/data"
SERVICE_NAME="minecraft_exporter.service"
USER="javi"
GROUP="javi"
REQUIREMENTS_FILE="/home/javi/minecraft-server/minecraft-exporter/requirements.txt"

# Verificar e instalar Python si no está instalado
if ! command -v python3 &> /dev/null; then
    echo "Python3 no encontrado. Instalando Python3..."
    sudo apt update
    sudo apt install -y python3 python3-pip
else
    echo "Python3 ya está instalado."
fi

# Instalar librerías de Python desde requirements.txt
if [ -f "$REQUIREMENTS_FILE" ]; then
    echo "Instalando librerías de Python desde $REQUIREMENTS_FILE..."
    sudo pip3 install -r $REQUIREMENTS_FILE
else
    echo "El archivo $REQUIREMENTS_FILE no existe. Asegúrate de que esté en la ubicación correcta."
    exit 1
fi

# Crear archivo de unidad de systemd
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME"

echo "Creando archivo de servicio en $SERVICE_FILE..."

sudo bash -c "cat > $SERVICE_FILE <<EOL
[Unit]
Description=Minecraft Exporter Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 $SCRIPT_PATH -f $MONITORING_DIRECTORY -i 60
WorkingDirectory=$(dirname $SCRIPT_PATH)
Restart=always
User=$USER
Group=$GROUP

[Install]
WantedBy=multi-user.target
EOL"

# Recargar systemd
echo "Recargando systemd..."
sudo systemctl daemon-reload

# Habilitar el servicio para que se inicie al arrancar
echo "Habilitando el servicio..."
sudo systemctl enable $SERVICE_NAME

# Iniciar el servicio
echo "Iniciando el servicio..."
sudo systemctl start $SERVICE_NAME

# Verificar el estado del servicio
echo "Estado del servicio:"
sudo systemctl status $SERVICE_NAME

# Consultar los logs del servicio
echo "Logs del servicio:"
journalctl -u $SERVICE_NAME
