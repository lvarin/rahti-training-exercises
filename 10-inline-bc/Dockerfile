FROM nginx:mainline-alpine

#RUN chmod g+rwX /var/cache/nginx /var/run /var/log/nginx
#RUN chgrp -R root /var/cache/nginx

COPY cfg/default.conf /etc/nginx/conf.d/default.conf
COPY cfg/nginx.conf /etc/nginx/nginx.conf
COPY cfg/index.html /usr/share/nginx/html/index.html
#RUN chmod -R g+rX /etc/nginx/

RUN chmod -R g+rX /usr/share/nginx/html
EXPOSE 8080

