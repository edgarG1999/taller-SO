##!/bin/bash

# Configuración
ORIGEN="/home/edgar/Escritorio/taller_SO/ejercicio_1/script"
DESTINO="/home/edgar/Escritorio/taller_SO/ejercicio_1/backups"
NOMBRE_BACKUP="respaldo_$(date +%Y-%m-%d).tar.gz"
REPO_DIR="/home/edgar/Escritorio/taller_SO"

echo "Iniciando proceso de respaldo y versionado..."

# 1. Crear respaldo
mkdir -p "$DESTINO"
tar -czf "$DESTINO/$NOMBRE_BACKUP" "$ORIGEN"

# 2. Verificar respaldo
if [ ! -f "$DESTINO/$NOMBRE_BACKUP" ]; then
echo "Error al crear el respaldo!"
exit 1
fi
# 3. Copiar respaldo al repositorio
cp "$DESTINO/$NOMBRE_BACKUP" "$REPO_DIR/backups/"

# 4. Actualizar repositorio Git
cd "$REPO_DIR"
git add backups/"$NOMBRE_BACKUP"
git commit -m "Respaldo automático: $(date +%Y-%m-%d)"
git push origin main
echo "Proceso completado con éxito!"
