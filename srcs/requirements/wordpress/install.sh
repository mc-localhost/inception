#!/bin/bash
cd /var/www/html
echo "i'm in /var/www/html"

# wp-cli.phar (PHP ARchive) is an archive that bundles the entire WP-CLI command-line interface for WordPress
if [ ! -f wp-cli.phar ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	echo "downloaded wp-cli.phar"
fi

if [ ! -f wp-config.php ]; then
	echo "no wp-config.php, downloading with wp-cli.phar"
	./wp-cli.phar core download --allow-root
	./wp-cli.phar config create \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_PASS" \
		--dbhost="$DB_HOST" \
		--allow-root
	echo "created config with DB_..."
	./wp-cli.phar core install \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USR" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email \
		--allow-root
	echo "installed core"
	./wp-cli.phar user create "$WP_USR" "$WP_EMAIL" \
        --user_pass="$WP_PWD" \
        --role=author \
        --allow-root
	echo "created user WP_USER as author"
fi

php-fpm7.4 -F
