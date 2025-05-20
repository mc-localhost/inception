#!/bin/bash

envsubst < /etc/mysql/init_env.sql > /etc/mysql/init.sql
# echo "after substitution:"
# cat /etc/mysql/init.sql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=root --datadir=/var/lib/mysql
    mysqld_safe --skip-networking &
    pid="$!"

    until mysqladmin ping --silent --user=root; do
        sleep 1
    done

    mysql < /etc/mysql/init.sql

    mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown

    wait "$pid"
fi

exec mysqld_safe