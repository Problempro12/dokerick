#!/bin/bash

# Останавливаем и удаляем старые контейнеры
docker stop instance-1 instance-2 2>/dev/null
docker rm instance-1 instance-2 2>/dev/null

# Получаем последние изменения из git
git pull

# Собираем новый образ
docker build -t test:latest .

# Запускаем первый контейнер
docker run -dp 3001:1234 \
    -e PORT=1234 \
    -e INSTANCE_ID=1 \
    -v "$(pwd)/logs:/usr/src/app/logs" \
    --name instance-1 \
    test:latest

# Запускаем второй контейнер
docker run -dp 3002:1234 \
    -e PORT=1234 \
    -e INSTANCE_ID=2 \
    -v "$(pwd)/logs:/usr/src/app/logs" \
    --name instance-2 \
    test:latest

echo "Containers updated and started. You can access them at:"
echo "Instance 1: http://localhost:3001"
echo "Instance 2: http://localhost:3002" 