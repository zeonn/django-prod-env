FROM debian:8
MAINTAINER zeon

RUN mkdir /backup
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install mysql-client netcat
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get -y autoremove
RUN apt-get -y clean
RUN apt-get -y autoclean
RUN mkfifo --mode 0666 /var/log/cron.log