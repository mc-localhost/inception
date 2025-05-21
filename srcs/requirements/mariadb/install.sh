#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=root --datadir=/var/lib/mysql
    mysqld_safe --skip-networking &
    pid="$!"
    # waiting for mysqladmin to run
    until mysqladmin ping --silent --user=root; do
        sleep 1
    done

    envsubst < /etc/mysql/init_env.sql > /etc/mysql/init.sql
    # to check in docker logs mariadb that substitution worked correctly 
    # echo "after substitution:"
    # cat /etc/mysql/init.sql
    mysql < /etc/mysql/init.sql

    mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown
    # wait for mysqld to be done, only to restart later in the code
    wait "$pid"
fi

exec mysqld_safe