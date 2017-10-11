#!/bin/sh
# Database restore script
# Don't edit this file!


#vars
source ./config.sh
export INIT_RESTORE_LATEST=1

docker-compose run backup
