#!/bin/bash
# Linux Server Health Monitor
# Checks CPU, memory, disk and network; logs results and alerts on threshold breaches.

CPU_LIMIT=80
MEM_LIMIT=80
DISK_LIMIT=80
HOST_TO_PING="8.8.8.8"
LOG_FILE="logs/health.log"
TS=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p logs

CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print int($2 + $4)}')
MEM=$(free | awk '/Mem:/ {printf "%d", $3/$2 * 100}')
DISK=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "[$TS] CPU=${CPU}% MEM=${MEM}% DISK=${DISK}%" >> "$LOG_FILE"

[ "$CPU" -gt "$CPU_LIMIT" ] && echo "[$TS] ALERT: High CPU usage (${CPU}%)" | tee -a "$LOG_FILE"
[ "$MEM" -gt "$MEM_LIMIT" ] && echo "[$TS] ALERT: High memory usage (${MEM}%)" | tee -a "$LOG_FILE"
[ "$DISK" -gt "$DISK_LIMIT" ] && echo "[$TS] ALERT: High disk usage (${DISK}%)" | tee -a "$LOG_FILE"

if ping -c 1 -W 2 "$HOST_TO_PING" > /dev/null 2>&1; then
  echo "[$TS] Network OK ($HOST_TO_PING reachable)" >> "$LOG_FILE"
else
  echo "[$TS] ALERT: Network unreachable ($HOST_TO_PING)" | tee -a "$LOG_FILE"
fi
exit 0
