FROM debian:bullseye

RUN apt update -y && \
	apt install -y \
	mariadb-server \
	gettext && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# contains init_file = /etc/mysql/init.sql line
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
# install.sh will turn env variables into sql-readable text and write into init.sql
COPY init_env.sql /etc/mysql/init_env.sql
# before:
# COPY init.sql /etc/mysql/init.sql
COPY install.sh .

RUN mkdir /run/mysqld

RUN chmod +x install.sh

CMD [ "./install.sh" ]