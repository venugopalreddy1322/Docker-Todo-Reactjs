FROM node:14-alpine AS builder
WORKDIR /app
COPY package*.json ./
COPY . ./
RUN npm update
RUN npm upgrade
RUN npm install
COPY . ./
RUN npm run build
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
