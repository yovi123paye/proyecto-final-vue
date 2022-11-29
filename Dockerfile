#Docker File del FRONT
FROM node:14.17.0-alpine as build-stage
RUN mkdir -p /appVue
WORKDIR /appVue
COPY package.json /appVue
RUN npm install
COPY . /appVue/
RUN npm run build --prod

FROM nginx:1.22.1
#RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
#COPY ./nginx.conf ./conf.d/default.conf
#COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf
#RUN rm -rf /usr/share/nginx/html/*
#RUN rm /etc/nginx/conf.d/default.conf
#COPY conf /etc/nginx
#COPY nginx.conf /etc/nginx/conf.d
#COPY nginx.conf /etc/nginx/nginx.conf
COPY ./configuracion/nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build-step /appVue/dist /usr/share/nginx/html

EXPOSE 4200:80
CMD ["nginx", "-g", "daemon off;"]
