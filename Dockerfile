FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Check what's in dist after build
RUN ls -la /app/dist/

FROM nginxinc/nginx-unprivileged:alpine

# Try copying from the correct path
COPY --from=build /app/dist/event-planner-frontend/browser /usr/share/nginx/html

# Replace main nginx config
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
