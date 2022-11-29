#Docker File del FRONT
FROM node:14.17.0-alpine as build-stage
RUN mkdir -p /appVue
WORKDIR /appVue
COPY package.json /appVue
RUN npm install
COPY . /appVue/
RUN npm run build --prod

FROM nginx:1.22.1
COPY ./configuracion/nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build-step /appVue/dist /usr/share/nginx/html

EXPOSE 4200:80
CMD ["nginx", "-g", "daemon off;"]
