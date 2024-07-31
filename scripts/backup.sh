#!/bin/bash

# Variables
SOURCE_DIR="/home/javi/minecraft-server/data"
BACKUP_DIR="/home/javi/minecraft-server/backups"
TIMESTAMP=$(date +"%Y-%m-%d")
BACKUP_FILE="$TIMESTAMP.tar.gz"

# Crear directorio de respaldo si no existe
mkdir -p $BACKUP_DIR

# Realizar la copia de seguridad
tar -zcvf $BACKUP_DIR/$BACKUP_FILE -C $SOURCE_DIR .

# Imprimir mensaje de éxito
echo "Copia de seguridad realizada con éxito: $BACKUP_DIR/$BACKUP_FILE"

# Eliminar copias de seguridad que tengan más de 7 días
find $BACKUP_DIR -name "*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

# Imprimir mensaje de limpieza de copias antiguas
echo "Copias de seguridad de más de 7 días eliminadas."