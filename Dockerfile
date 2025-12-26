FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginxinc/nginx-unprivileged:alpine

# Copy the built app
COPY --from=build /app/dist/event-planner-frontend/browser /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Use port 8080 instead of 80
EXPOSE 8080

USER nginx
