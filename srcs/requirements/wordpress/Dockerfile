FROM debian:bullseye

RUN apt update -y && \
	apt install -y \
	php-fpm php-mysql curl

RUN mkdir /run/php
RUN mkdir -p /var/www/html

# since only 1 line gets changed, it is easier to do that directly with sed -i
# COPY www.conf /etc/php/7.4/fpm/pool.d/.
RUN sed -i 's|^listen = .*|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY install.sh .

RUN chmod +x install.sh

CMD ["./install.sh"]