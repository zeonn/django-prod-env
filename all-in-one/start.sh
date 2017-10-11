#!/bin/sh
# main start point

echo "Setting run permissions for all script files"
for file in `find ./ -type f -name "*.sh"`
do
   chmod +x $file;
done

echo "Setting up enviroment variables"
source ./config.sh

echo "Starting docker-compose"
cp ${PROJECT_ROOT}/requirements.txt ./docker/web/requirements.txt
docker-compose up -d --build
rm ./docker/web/requirements.txt