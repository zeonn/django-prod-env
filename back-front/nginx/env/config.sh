#!/bin/sh
# Edit this file with your configurations


# Common:
DJANGO_DOMAIN_NAME="youtsite.com"
REDMINE_DOMAIN_NAME="pm.youtsite.com"

HTTPS=0										# 1 - https on | 0 - https off (http only)
ADMIN_EMAIL="admin@yoursite.com"
GUNICORN_PORT="8000"
REDMINE_PORT="3000"
FLOWER_PORT="5555"


# Paths:
LOGS_DIR="/path/to/project/nginx/logs"						# Logs dir
WEBROOT_DIR="/path/to/project/nginx/webroot"				# Let's Encript workdir

PROJECT_ROOT="/path/to/project/myproject"					# Your dango project root folder


# Setting enviroment variables
# Don't edit this
export DJANGO_DOMAIN_NAME=$DJANGO_DOMAIN_NAME
export REDMINE_DOMAIN_NAME=$REDMINE_DOMAIN_NAME
export LOGS_DIR=$LOGS_DIR
export HTTPS=$HTTPS
export ADMIN_EMAIL=$ADMIN_EMAIL
export WEBROOT_DIR=$WEBROOT_DIR
export GUNICORN_PORT=$GUNICORN_PORT
export PROJECT_ROOT=$PROJECT_ROOT
export REDMINE_PORT=$REDMINE_PORT
export FLOWER_PORT=$FLOWER_PORT
