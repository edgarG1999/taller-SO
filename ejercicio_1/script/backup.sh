#!/bin/bash

# Configuración
FECHA=$(date +%Y-%m-%d)
ORIGEN="/home/edgar/Escritorio/taller SO/ejercicio_1/script"
DESTINO="/home/edgar/Escritorio/taller SO/ejercicio_1/backups"
REPO_DIR="/home/edgar/Escritorio/taller SO"
NOMBRE_BACKUP="respaldo_$(date +%Y-%m-%d).tar.gz"

# 1. Crear backup local
mkdir -p "$DESTINO"
tar -czf "$DESTINO/$NOMBRE_BACKUP" "$ORIGEN"

# 2. Verificar si el backup se creó
if [ ! -f "$DESTINO/$NOMBRE_BACKUP" ]; then
    echo "Error: No se pudo crear el backup!"
    exit 1
fi

# 3. Copiar backup al repositorio Git
cp "$DESTINO/$NOMBRE_BACKUP" "$REPO_DIR/"

# 4. Subir a GitHub
cd "$REPO_DIR"
git add "$NOMBRE_BACKUP"
git commit -m "Backup automático $(date +%Y-%m-%d)"
git push origin main

echo "Backup y push a GitHub completados!"
