#!/bin/bash

# Save terminal history script for DevOps practice
# Автор: Nick
# Цель: Автоматическое сохранение истории команд для портфолио и самоанализа

# Определяем директорию проекта (где лежит скрипт)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

HISTORY_DIR="$PROJECT_ROOT/history"
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
HISTORY_FILE="$HISTORY_DIR/history_${DATE}.txt"

# Создаём папку history, если её нет
mkdir -p "$HISTORY_DIR"

# Сохраняем текущую историю из памяти в файл ~/.bash_history
history -a

# Если ~/.bash_history существует — копируем его содержимое
if [ -f ~/.bash_history ]; then
    echo "=== History saved at ${DATE} ${TIME} ===" >> "$HISTORY_FILE"
    echo ">>> New commands from this session:" >> "$HISTORY_FILE"
    
    # Копируем весь файл (простой и надёжный способ)
    cat ~/.bash_history >> "$HISTORY_FILE"
    
    echo ">>> End of session ${DATE} ${TIME}" >> "$HISTORY_FILE"
    echo "" >> "$HISTORY_FILE"
    
    echo "✅ History successfully saved to: $HISTORY_FILE"
    echo "Lines in file: $(wc -l < "$HISTORY_FILE")"
else
    echo "⚠️  Warning: ~/.bash_history not found"
fi
