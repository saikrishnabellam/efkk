FROM nginx:1.13
COPY ./nginx.conf /etc/nginx/
EXPOSE 80 443 24224
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
