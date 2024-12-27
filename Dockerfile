FROM nginx:alpine
#COPY nginx/stag-nginx.conf /etc/nginx/conf.d/default.conf
COPY app /usr/share/nginx/html
