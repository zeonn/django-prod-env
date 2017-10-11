#!/bin/sh
# based on ideas of https://github.com/tutumcloud/mysql-backup


BACKUP_CMD='mysqldump -h ${MYSQL_HOST} -P ${MYSQL_PORT} -u root -p${MYSQL_ROOT_PASSWORD} ${EXTRA_OPTS} ${MYSQL_DB} | gzip > /backup/${BACKUP_NAME}'
RESTORE_CMD='gunzip < $1 | mysql -h ${MYSQL_HOST} -P ${MYSQL_PORT} -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DB}'
touch /logs/backup.log


echo "=> Creating backup script"
rm -f /backup.sh
cat <<EOF >> /backup.sh
#!/bin/sh
MAX_BACKUPS=${MAX_BACKUPS}

BACKUP_NAME=\$(date +\%Y.\%m.\%d.\%H\%M).gz

echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Backup started: \${BACKUP_NAME}"
if ${BACKUP_CMD} ;then
    echo "   Backup succeeded"
else
    echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Backup failed"
    rm -rf /backup/\${BACKUP_NAME}
fi

if [ -n "\${MAX_BACKUPS}" ]; then
    while [ \$(ls /backup -1 | wc -l) -gt \${MAX_BACKUPS} ];
    do
        BACKUP_TO_BE_DELETED=\$(ls /backup -1 | sort | head -n 1)
        echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Backup \${BACKUP_TO_BE_DELETED} is deleted"
        rm -rf /backup/\${BACKUP_TO_BE_DELETED}
    done
fi
echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Backup done"
EOF
chmod +x /backup.sh


echo "=> Creating restore script"
rm -f /restore.sh
cat <<EOF >> /restore.sh
#!/bin/sh
echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Restore database from \$1"
if ${RESTORE_CMD} ;then
    echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Restore succeeded"
else
    echo "\$(date +\%Y.\%m.\%d.\%H\%M) => Restore failed"
fi
echo "=> Done"
EOF
chmod +x /restore.sh


if [ ${INIT_BACKUP} = 1 ]; then
    echo "=> Create a backup on the startup"
    /backup.sh > /logs/backup.log
elif [ ${INIT_RESTORE_LATEST} = 1 ]; then
    echo "=> Restore lates backup"
    until nc -z $MYSQL_HOST $MYSQL_PORT
    do
        echo "waiting database container..."
        sleep 1
    done
    ls -d -1 /backup/* | tail -1 | xargs /restore.sh > /logs/backup.log
fi
