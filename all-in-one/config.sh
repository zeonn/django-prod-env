#!/bin/sh
# Edit this file with your configurations


# Common:
DOMAIN_NAME="yoursite.com"
LANG="C.UTF-8"
HTTPS=0												# 1 - https on | 0 - https off (http only)
ADMIN_EMAIL="admin@yoursite.com"


# Paths:
PROJECT_ROOT="/path/to/project/myproject"			# Your dango project root folder
LOGS_DIR="/path/to/project/logs"					# Logs dir
BACKUP_DIR="/path/to/project/backup"				# Database backups


# Django:
DJANGO_MAIN_APP="app"


# Gunicorn:
GUNICORN_WORKERS_COUNT="3"
GUNICORN_PORT="8000"


# MySQL:
MYSQL_ROOT_PASSWORD="mysql-root-passwd"
MYSQL_DATABASE="database"
MYSQL_USER="username"
MYSQL_PASSWORD="mysql-username-passwd"


#  DB Backup
BACKUP_CRON_TIME="0 0 * * *"						# do backup every day at 00:00
MAX_BACKUPS=3
INIT_BACKUP=0										# run backup at container startup (0 - no | 1 - yes)
INIT_RESTORE_LATEST=0								# restore from last backup (0 - no | 1 - yes)


# Setting enviroment variables
# Don't edit this
export DOMAIN_NAME=$DOMAIN_NAME
export LANG=$LANG
export PROJECT_ROOT=$PROJECT_ROOT
export LOGS_DIR=$LOGS_DIR
export BACKUP_DIR=$BACKUP_DIR
export DJANGO_MAIN_APP=$DJANGO_MAIN_APP
export GUNICORN_WORKERS_COUNT=$GUNICORN_WORKERS_COUNT
export GUNICORN_PORT=$GUNICORN_PORT
export MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
export MYSQL_DATABASE=$MYSQL_DATABASE
export MYSQL_USER=$MYSQL_USER
export MYSQL_PASSWORD=$MYSQL_PASSWORD
export BACKUP_CRON_TIME=$BACKUP_CRON_TIME
export MAX_BACKUPS=$MAX_BACKUPS
export INIT_BACKUP=$INIT_BACKUP
export INIT_RESTORE_LATEST=$INIT_RESTORE_LATEST
export HTTPS=$HTTPS
export ADMIN_EMAIL=$ADMIN_EMAIL
