FROM node:14-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# tell aws beanstalk to map port 80 for incoming traffic
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
