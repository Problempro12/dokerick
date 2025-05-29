#!/bin/bash

# Создаем директорию для логов
mkdir -p ./logs

# Останавливаем и удаляем старые контейнеры
docker stop instance-1 instance-2 2>/dev/null
docker rm instance-1 instance-2 2>/dev/null

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

# Создаем тестовый файл в директории логов
echo "Test file content" > ./logs/test.txt

echo "docker exec -it instance-1 sh -c 'ls -l /usr/src/app/logs'"
echo "docker exec -it instance-2 sh -c 'ls -l /usr/src/app/logs'" 