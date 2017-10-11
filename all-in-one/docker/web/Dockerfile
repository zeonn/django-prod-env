FROM python:3.6
MAINTAINER zeon
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install python3-pip python3-dev python3-setuptools python-mysqldb supervisor
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get -y autoremove
RUN apt-get -y clean
RUN apt-get -y autoclean
ENV work_dir /site/
RUN mkdir $work_dir
WORKDIR $work_dir
COPY requirements.txt $work_dir
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
