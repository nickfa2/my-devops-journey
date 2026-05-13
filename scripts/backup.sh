#!/bin/bash

# Backup script for DevOps practice
# Автор: Nick
# Цель: Чистый бэкап учебных материалов без мусора

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

BACKUP_DIR="$PROJECT_ROOT/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="practice_backup_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "=== Backup started at $(date) ==="

cd "$PROJECT_ROOT" || exit 1

# Копируем только нужные файлы, исключая backups и history
find . -maxdepth 2 \( -name "*.md" -o -name "*.sh" \) \
    -not -path "./backups/*" \
    -not -path "./history/*" \
    -not -name "practice_backup_*.tar.gz" | while read -r file; do
    cp "$file" "$BACKUP_DIR/" 2>/dev/null
done

# Создаём архив
cd "$BACKUP_DIR" || exit 1
tar -czf "$BACKUP_NAME" --exclude="practice_backup_*.tar.gz" . 2>/dev/null

echo "Backup completed: $BACKUP_NAME"
echo "Size: $(du -h "$BACKUP_NAME" | cut -f1 2>/dev/null || echo 'Unknown')"
echo "=== Backup finished at $(date) ==="

cd "$PROJECT_ROOT"
