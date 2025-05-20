FROM debian:bullseye

RUN apt update -y && \
	apt install -y \
	# mariadb-client \
	php-fpm php-mysql curl

RUN mkdir /run/php
RUN mkdir -p /var/www/html

# COPY www.conf /etc/php/7.4/fpm/pool.d/.
RUN sed -i 's|^listen = .*|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY install.sh .

RUN chmod +x install.sh

CMD ["./install.sh"]