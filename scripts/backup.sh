#!/bin/bash

# Variables por defecto
SOURCE_DIR="/home/javi/minecraft-server/data"
BACKUP_DIR="/home/javi/minecraft-server/backups"
TIMESTAMP=$(date +"%Y-%m-%d")
BACKUP_FILE="$TIMESTAMP.tar.gz"

# Variables de montaje
SERVER=""
FOLDER=""
MOUNTPOINT="$BACKUP_DIR"
USER=""
PASSWORD=""

# Función para mostrar la ayuda
mostrar_ayuda() {
    echo "Opciones:"
    echo "  -server <IP-servidor>     Dirección IP del servidor de archivos."
    echo "  -folder <nombre_de_carpeta> Nombre de la carpeta compartida en el servidor."
    echo "  -mountpoint <punto_de_montura> Directorio local donde se montará el volumen (opcional)."
    echo "  -user <usuario>          Nombre de usuario para la autenticación (opcional)."
    echo "  -password <contraseña>   Contraseña para la autenticación (opcional)."
    echo "  -help                    Mostrar esta ayuda y salir."
    exit 0
}

# Procesar los parámetros
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -server) SERVER="$2"; shift ;;
        -folder) FOLDER="$2"; shift ;;
        -mountpoint) MOUNTPOINT="$2"; shift ;;
        -user) USER="$2"; shift ;;
        -password) PASSWORD="$2"; shift ;;
        -help) mostrar_ayuda ;;
        -m) MOUNT=true ;;  # Indica que se debe montar el volumen en red
        *) echo "Opción desconocida: $1"; mostrar_ayuda ;;
    esac
    shift
done

# Crear directorio de respaldo si no existe
mkdir -p $BACKUP_DIR

# Montar el volumen en red si se especificó -m y todos los parámetros necesarios están presentes
if [ "$MOUNT" = true ]; then
    if [ -z "$SERVER" ] || [ -z "$FOLDER" ]; then
        echo "Error: Se requieren los parámetros -server y -folder para montar el volumen en red."
        exit 1
    fi

    echo "Montando el volumen en red..."
    MOUNT_CMD="sudo mount -t cifs //$SERVER/$FOLDER $MOUNTPOINT"
    
    if [ -n "$USER" ] && [ -n "$PASSWORD" ]; then
        MOUNT_CMD+=" -o username=$USER,password=$PASSWORD"
    fi

    # Ejecutar el comando de montaje
    $MOUNT_CMD

    # Verificar si el montaje fue exitoso
    if [ $? -ne 0 ]; then
        echo "Error al montar el volumen en red."
        exit 1
    fi
    
    # Recargar los servicios del sistema
    sudo systemctl daemon-reload
    echo "Volumen en red montado exitosamente en $MOUNTPOINT."
fi

# Realizar la copia de seguridad
tar -zcvf $BACKUP_DIR/$BACKUP_FILE -C $SOURCE_DIR .

# Imprimir mensaje de éxito
echo "Copia de seguridad realizada con éxito: $BACKUP_DIR/$BACKUP_FILE"

# Eliminar copias de seguridad que tengan más de 2 días
find $BACKUP_DIR -name "*.tar.gz" -type f -mtime +2 -exec rm -f {} \;

# Imprimir mensaje de limpieza de copias antiguas
echo "Copias de seguridad de más de 2 días eliminadas."
