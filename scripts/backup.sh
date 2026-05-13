#!/bin/bash

# Backup script for DevOps practice
# Автор: Nick
# Цель: Чистый бэкап только учебных материалов (документация и конспекты)

# Определяем пути относительно расположения скрипта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

BACKUP_DIR="$PROJECT_ROOT/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="practice_backup_${TIMESTAMP}.tar.gz"

# Создаём папку для бэкапов
mkdir -p "$BACKUP_DIR"

echo "=== Backup started at $(date) ==="
echo "Project root: $PROJECT_ROOT"

# Переходим в корень проекта
cd "$PROJECT_ROOT" || exit 1

# Копируем ТОЛЬКО важные файлы (без скриптов из папки scripts)
echo "Copying documentation files..."

cp README.md "$BACKUP_DIR/" 2>/dev/null
cp docs/*.md "$BACKUP_DIR/" 2>/dev/null

# Если хочешь бэкапить другие расширения — добавь сюда

echo "Creating archive..."
cd "$BACKUP_DIR" || exit 1

tar -czf "$BACKUP_NAME" *.md 2>/dev/null

echo "Backup completed: $BACKUP_NAME"
echo "Size: $(du -h "$BACKUP_NAME" | cut -f1 2>/dev/null || echo 'Unknown')"
echo "=== Backup finished at $(date) ==="

# Возвращаемся обратно в корень проекта
cd "$PROJECT_ROOT"
