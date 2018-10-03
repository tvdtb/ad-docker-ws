FROM nginx:latest
MAINTAINER Christian Haefner <christian.haefner@trivadis.com>

COPY index.html /usr/share/nginx/html
COPY trivadis.png /usr/share/nginx/html
COPY docker.png /usr/share/nginx/html

EXPOSE 80 443 	

CMD ["nginx", "-g", "daemon off;"]