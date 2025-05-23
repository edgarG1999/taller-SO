#!/bin/bash

# Configuración
ORIGEN="/home/edgar/Escritorio/taller_SO_practica/ejercicio_1/script"
DESTINO="/home/edgar/Escritorio/taller_SO_practica/ejercicio_1/backups"
NOMBRE_BACKUP="respaldo_$(date +%Y-%m-%d).tar.gz"
REPO_DIR="/home/edgar/Escritorio/taller_SO_practica"
LOG_FILE="/home/edgar/Escritorio/taller_SO_practica/ejercicio_1/backups/backup.log"

# Crear directorio de backups y archivo log (si no existen)
mkdir -p "$DESTINO"
touch "$LOG_FILE"

# Redirigir TODA la salida (stdout + stderr) al log
exec >> "$LOG_FILE" 2>&1

echo "=========================================="
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Iniciando proceso de respaldo..."

# 1. Crear respaldo
echo "Comprimiendo $ORIGEN..."
if /bin/tar -czf "$DESTINO/$NOMBRE_BACKUP" "$ORIGEN"; then
    echo "Respaldo creado: $DESTINO/$NOMBRE_BACKUP"
else
    echo "ERROR: Fallo al crear el respaldo"
    exit 1
fi

# [ELIMINADO EL PASO DE COPIA INNECESARIO]

# 2. Versionado en Git
cd "$REPO_DIR" || exit 1
echo "Actualizando repositorio Git..."

# Configurar Git (solo necesario la primera vez)
git config --global user.email "ef.edgar1999@gmail.com"
git config --global user.name "edgarG1999"

# Añadir TODOS los archivos modificados (incluyendo el log y backups)
git add -A

# Commit
git commit -m "Respaldo automático: $(date +%Y-%m-%d)" || echo "No hay cambios nuevos"

# Push con SSH
if GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git push origin master; then
    echo "Push a GitHub exitoso"
else
    echo "ERROR: Fallo al hacer push"
    exit 1
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Proceso completado con éxito"
echo "=========================================="