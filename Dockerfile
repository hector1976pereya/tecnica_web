# Etapa 1: Construcción
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servidor de producción
FROM nginx:stable-alpine
# Copiamos los archivos compilados desde la etapa anterior
COPY --from=build /app/dist /usr/share/nginx/html
# Exponemos el puerto 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]