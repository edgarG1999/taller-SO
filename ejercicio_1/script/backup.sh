#!/bin/bash

# Configuración
FECHA=$(date +%Y-%m-%d)
ORIGEN="/home/edgar/Escritorio/taller SO/ejercicio_1/script"
DESTINO="/home/edgar/Escritorio/taller SO/ejercicio_1/backups"
LOGFILE="/home/edgar/Escritorio/backups/backup.log"

# Crear directorio de backups si no existe
mkdir -p "$DESTINO"

# Crear backup comprimido
echo "[$(date +%Y-%m-%d%H:%M:%S)] Iniciando backup..." >> "$LOGFILE"
tar -czf "$DESTINO/backup_$FECHA.tar.gz" "$ORIGEN" 2>> "$LOGFILE"

# Verificar éxito
if [ $? -eq 0 ]; then
    echo "[$(date +%Y-%m-%d%H:%M:%S)] Backup completado: $DESTINO/backup_$FECHA.tar.gz" >> "$LOGFILE"
else
    echo "[$(date +%Y-%m-%d%H:%M:%S)] Error al crear backup!" >> "$LOGFILE"
fi

# Eliminar backups antiguos (más de 7 días)
find "$DESTINO" -name "backup_*.tar.gz" -mtime +7 -delete 2>> "$LOGFILE"
