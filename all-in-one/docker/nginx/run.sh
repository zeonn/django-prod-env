#!/bin/sh
# Don't edit this


touch /logs/nginx-access.log
touch /logs/nginx-error.log
touch /logs/nginx-start.log
export DOLLAR="$"

echo "---------------------------------------------" >> /logs/nginx-start.log
echo "$(date +\%Y.\%m.\%d.\%H\%M) => Starting nginx" >> /logs/nginx-start.log

if [ ${HTTPS} = 1 ]; then
    echo "=> Generating nginx config for https" >> /logs/nginx-start.log
    envsubst < nginx-ssl.conf.template > /etc/nginx/conf.d/default.conf
else
    echo "=> Generating nginx config for http" >> /logs/nginx-start.log
    envsubst < nginx.conf.template > /etc/nginx/conf.d/default.conf
fi

echo "$(nginx -v)" >> /logs/nginx-start.log
echo "$(nginx -t)" >> /logs/nginx-start.log
nginx -g "daemon off;"
