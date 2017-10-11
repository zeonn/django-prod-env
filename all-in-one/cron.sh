#!/bin/sh
# add tasks to host system cron
# Don't edit this file!


# add task
crontab -l > ./crontab.conf
cat <<EOF >> ./crontab.conf
0 0 * * * export INIT_BACKUP=1
0 0 * * * docker-compose run backup > ${LOGS_DIR}/backup.log 2>&1
1 0 * * * find ${LOGS_DIR} -regex '.*[0-9].*' -exec rm -f {} \;

EOF

# read config
crontab ./crontab.conf
rm ./crontab.conf
