#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    mysqld_safe --user=mysql &
    pid="$!"
    until mysqladmin -u root ping -h localhost --silent; do
        echo "waiting for mysqladmin to run..."
        sleep 1
    done

    envsubst < /etc/mysql/init_env.sql > /etc/mysql/init.sql
    # to check in docker logs mariadb that substitution worked correctly 
    echo "after substitution:"
    cat /etc/mysql/init.sql
    mysql < /etc/mysql/init.sql

    mysqladmin -u root -p${DB_ROOT_PASS} shutdown
    # wait for mysqld to be done, only to restart later in the code
    wait "$pid"
fi

exec mysqld_safe --user=mysql