#!/bin/bash
LOG_FILE="/home/edgar/Escritorio/var/log/monitor_recursos.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
 sed "s/.,([0-9.])% id./\1/" | \
 awk '{print 100 - $1}')
MEMORY_USAGE=$(free -m | \
 awk '/Mem:/ {printf "%.2f", $3/$2*100}')
# Asegurarse de que el directorio existe
mkdir -p "$(dirname "$LOG_FILE")"
echo "$TIMESTAMP - CPU: $CPU_USAGE% - Memoria: $MEMORY_USAGE%" >> "$LOG_FILE"