django-prod-env (back-front)
========================

Production environment for running one ore more Django applications and other applications (Redmine, for example) in separated docker containers


Installation
------------

Upload or gitclone these folder to your production server.
Also, place your application (applications) folders to the server.


Requeriments
------------

1. Ubuntu linux x64 16.04+
2. Django 1.9+ application


Usage
-----

1. Go to ``'env'`` folders in django applications and ``nginx``: 
    ```bash
    cd env
    ```
2. Edit all ``'config.sh'``files in these folders with your configuration settings
3. For installing docker and docker-compose you can use ``'docker-install.sh'`` script:
    ```bash
    sudo ./docker-install.sh
    ```
4. Relogin (logout/login) or reboot your server
5. Add to the bottom of your Django main configuraton file:
    ```python
    # importing production environment settings
    try:
        ENV = os.environ["ENV"]
    except KeyError:
        ENV = 'dev'
    if ENV == 'prod':
    try:
            from .prod_settings import *
        except ImportError as er:
            print("production settings import error")
            print(er.__str__())
    if ENV == 'dev':
        STATICFILES_DIRS = (os.path.join(BASE_DIR, 'static'),)
    ```
6. Run backand environments (in the ``env`` folders of your applications):
    ```bash
    . start.sh
    ```
    or
    ```bash
    source start.sh
    ```
7. Run frontend environment (in ``nginx/env`` folder):
    ```bash
    . start.sh
    ```
    or
    ```bash
    source start.sh
    ```
8. You can restore your databese from backup (replase all uppercase variables with your names):
    ```bash
    gunzip < /BACKUPFOLDER/BACKUPNAME.gz | mysql -h db -P 3306 -u root -pDATABASEROOTPASSWORD DATABASENAME
    ```
9. Request ssl certificates (in ``nginx/env`` folder):
    ```bash
    ./letsencrypt.sh
    ```
10. Add cert renew task to root's crontab (sudo crontab -e):
    ```bash
    # letsencrypt cert renew
    30 5 * * 1 letsencrypt renew
    35 5 * * 1 docker exec -d nginx bash -c "service nginx reload"
    ```
11. Optional, add clear logs task to user crontab (crontab -e):
    ```bash
    # clear logs
    1 0 * * * find $HOME/logs/ -regex '.*[0-9].*' -exec rm -f {} \;
    ```
12. Stop backand environments (in the ``env`` folders of your applications):
    ```bash
    docker-compose down
    ```
13. Replace ``HTTPS=0`` in ``'nginx/env/config.sh'`` file to ``HTTPS=1``
14. Run backand environments (in the ``env`` folders of your applications):
    ```bash
    . start.sh
    ```
    or
    ```bash
    source start.sh
    ```
15. Run frontend environment (in ``nginx/env`` folder):
    ```bash
    . start.sh
    ```
    or
    ```bash
    source start.sh
    ```


Backup and restore database
---------------------------

1. Go to ``'env'`` folder of your backand application: 
    ```bash
    cd env
    ```
2. Edit ``'db_backup.sh'`` file with your configurations
3. For backup your database, run:
    ```bash
    . db_backup.sh
    ```
    or
    ```bash
    source db_backup.sh
    ```
Your database backup will be placed to the ``BACKUP_DIR`` folder (see your ``'config.sh'`` file)
4. For restore last backup from the ``BACKUP_DIR`` folder, run:
    ```bash
    ./db_restore.sh
    ```
