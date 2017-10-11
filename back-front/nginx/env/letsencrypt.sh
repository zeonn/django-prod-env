#!/bin/sh
# generate letsencrypt certificates

sudo apt-get update
sudo apt-get install letsencrypt -y
sudo letsencrypt certonly -a webroot --webroot-path=${WEBROOT_DIR} -d ${DJANGO_DOMAIN_NAME} -d ${REDMINE_DOMAIN_NAME} --email ${ADMIN_EMAIL} --agree-tos
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo chown ${USER}:www-data /etc/ssl/certs/dhparam.pem
sudo chown ${USER}:www-data /etc/letsencrypt
sudo chown -R ${USER}:www-data /etc/letsencrypt/*
