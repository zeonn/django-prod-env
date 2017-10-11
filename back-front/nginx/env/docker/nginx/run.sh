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
    envsubst < django-ssl.conf.template > /etc/nginx/conf.d/django.conf
    envsubst < redmine-ssl.conf.template > /etc/nginx/conf.d/redmine.conf
else
    echo "=> Generating nginx config for http" >> /logs/nginx-start.log
    envsubst < django.conf.template > /etc/nginx/conf.d/django.conf
    envsubst < redmine.conf.template > /etc/nginx/conf.d/redmine.conf
fi

# redmine

echo "$(nginx -v)" >> /logs/nginx-start.log
echo "$(nginx -t)" >> /logs/nginx-start.log
nginx -g "daemon off;"
