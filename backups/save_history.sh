#!/bin/bash
DATE=$(date +"%Y-%m-%d")
HISTORY_FILE="history/history_${DATE}.txt"

mkdir -p history
history -a
cp ~/.bash_history "$HISTORY_FILE"   # или только новые строки, но для начала так
echo "=== History saved at $(date) ===" >> "$HISTORY_FILE"
