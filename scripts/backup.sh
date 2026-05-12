#!/bin/bash

# Backup script for DevOps practice
# Автор: Nick
# Дата: $(date)

BACKUP_DIR="/home/nick/my-devops-journey/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="practice_backup_${TIMESTAMP}.tar.gz"

# Создаём папку для бэкапов, если её нет
mkdir -p "$BACKUP_DIR"

# Что бэкапим (твои конспекты, скрипты и т.д.)
echo "=== Starting backup at $(date) ==="

# Копируем нужные файлы (пример: все .md и .sh в текущей папке)
cp *.md *.sh "$BACKUP_DIR/" 2>/dev/null || echo "No files to copy"

# Создаём архив
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$BACKUP_DIR/"*.md "$BACKUP_DIR/"*.sh 2>/dev/null

# Логируем результат
echo "Backup completed: $BACKUP_NAME" 
echo "Backup size: $(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)"

echo "=== Backup finished at $(date) ==="

git add history/
git commit -m "Daily history and backup update - $(date +"%Y-%m-%d")"
git push

