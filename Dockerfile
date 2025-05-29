# Используем официальный образ Node.js
FROM node:alpine

# Создаем рабочую директорию в контейнере
WORKDIR /app

# Копируем package.json и package-lock.json (если есть)
COPY package*.json ./

# Устанавливаем зависимости
RUN npm i

# Копируем исходный код приложения
COPY src ./src

EXPOSE 3000

# Запускаем приложение
CMD ["npm", "start"] 