#!/bin/bash

# Остановка и удаление старого контейнера
docker stop test-container 2>/dev/null
docker rm test-container 2>/dev/null

# Сборка нового образа
docker build -t test:latest .

# Запуск нового контейнера
docker run -dp 3000:1234 -e PORT=1234 -e NODE_ENV=production -e APP_VERSION=1.0.0 --name test-container test:latest

# Вывод логов
echo "Container logs:"
docker logs test-container 