#!/bin/sh
# Starting in backend container
# Don't edit this file!


# var
SUPERVISOR_CONF="/etc/supervisor/conf.d/django.conf"
SUPERVISOR_LOG="/logs/supervisor.log"
GUNICORN_LOG="/logs/gunicorn.log"


# create log files
touch ${SUPERVISOR_LOG}
touch ${GUNICORN_LOG}


# run gunicorn command
RUN_COMMAND="gunicorn \
--workers ${GUNICORN_WORKERS_COUNT} \
--env DJANGO_SETTINGS_MODULE=${DJANGO_MAIN_APP}.settings \
--bind 0.0.0.0:${GUNICORN_PORT} \
--reload ${DJANGO_MAIN_APP}.wsgi"


echo "=> Creating django app production settings file"
PROD_SETTINGS="/site/${DJANGO_MAIN_APP}/prod_settings.py"
rm -f ${PROD_SETTINGS}
cat <<EOF >> ${PROD_SETTINGS}
import os
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '${MYSQL_DATABASE}',
        'USER': '${MYSQL_USER}',
        'PASSWORD': '${MYSQL_PASSWORD}',
        'HOST': 'django-db',
        'PORT': '3306',
        'CHARSET': 'utf8',
        'COLLATION': 'utf8_general_ci',
    }
}
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
STATIC_URL = '/static/'
DEBUG = False
ALLOWED_HOSTS = ['*', ]

BROKER_URL='${BROKER_URL}'
RABBITMQ_USER='${RABBITMQ_USER}'
RABBITMQ_PASS='${RABBITMQ_PASS}'
EOF


echo "=> Creating supervisor config"
rm -f ${SUPERVISOR_CONF}
cat <<EOF >> ${SUPERVISOR_CONF}
[supervisord]
nodaemon = true
logfile = ${SUPERVISOR_LOG}
pidfile = /var/run/supervisord.pid
childlogdir = /logs

[unix_http_server]
file = /var/run/supervisor.sock
chmod = 0700
username = supervisor
password = rYacYHfT4x4bLJbw

[supervisorctl]
serverurl = unix:///var/run/supervisor.sock
username = supervisor
password = rYacYHfT4x4bLJbw

[program:gunicorn]
command = ${RUN_COMMAND}
directory = /site
stopsignal = KILL
user = root
autostart = true
autorestart = true
stdout_logfile = ${GUNICORN_LOG}
stderr_logfile = ${GUNICORN_LOG}
environment = LANG=${LANG},ENV=prod
EOF


# apply all django db migrations
python manage.py makemigrations
python manage.py migrate

# collect static files (only for django 1.9+)
python manage.py collectstatic --no-input


# restart supervisor
service supervisor restart

# reread and check supervisor
supervisorctl reload
supervisorctl update
supervisorctl start gunicorn
supervisorctl status gunicorn >> ${SUPERVISOR_LOG}
