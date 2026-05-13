#!/bin/bash

# Backup script for DevOps practice
# Автор: Nick
# Дата создания: 2026
# Описание: Создаёт бэкап учебных материалов

# === Определяем директорию, где лежит скрипт (самое важное!) ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"   # Переходим на уровень выше scripts/

BACKUP_DIR="$PROJECT_ROOT/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="practice_backup_${TIMESTAMP}.tar.gz"

# Создаём папку backups
mkdir -p "$BACKUP_DIR"

echo "=== Backup started at $(date) ==="
echo "Project root: $PROJECT_ROOT"

# Копируем только нужные файлы (исключаем backups и history, чтобы не было бардака)
cd "$PROJECT_ROOT" || exit 1

find . -maxdepth 2 \( -name "*.md" -o -name "*.sh" \) \
    -not -path "./backups/*" \
    -not -path "./history/*" \
    -exec cp {} "$BACKUP_DIR/" \; 2>/dev/null

# Создаём архив
cd "$BACKUP_DIR" || exit 1
tar -czf "$BACKUP_NAME" *.md *.sh 2>/dev/null

echo "Backup completed: $BACKUP_NAME"
echo "Size: $(du -h "$BACKUP_NAME" | cut -f1)"
echo "=== Backup finished at $(date) ==="

# Возвращаемся в корень проекта
cd "$PROJECT_ROOT"

