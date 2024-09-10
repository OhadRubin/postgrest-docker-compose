FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80
EXPOSE 80 5800
