#!/bin/sh
# Database restore script
# Don't edit this file!


#vars
cd /path/to/project/env
source ./config.sh
export INIT_BACKUP=1

docker-compose run backup
