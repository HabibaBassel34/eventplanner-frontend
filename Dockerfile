FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginxinc/nginx-unprivileged:alpine

# Copy Angular build output (NO /browser)
COPY --from=build /app/dist/event-planner-frontend /usr/share/nginx/html

# Replace main nginx config
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
