#!/bin/sh

    if test -e /var/www/localhost/htdocs/installed; then
    echo "Wordpress is installed, AWESOME!"
    else
    mkdir -p /var/www/localhost/htdocs
    cp -R /var/www/temp/htdocs/* /var/www/localhost/htdocs/
    chmod 777 -R -c /var/www/
    /usr/local/bin/wp core install --url=http://localhost:5050 --path=/var/www/localhost/htdocs/ --title=FT_SERVICES --admin_user=wp_admin --admin_password=123456 --admin_email=ineumann@student.42madrid.com --skip-email
    /usr/local/bin/wp user create user1 user1@ftserver.fr --path=/var/www/localhost/htdocs/ --user_pass=123456 --role=editor
    /usr/local/bin/wp user create user2 user2@ftserver.fr --path=/var/www/localhost/htdocs/ --user_pass=123456 --role=contributor
    /usr/local/bin/wp user create user3 user3@ftserver.fr --path=/var/www/localhost/htdocs/ --user_pass=123456 --role=subscriber
    fi
    touch /var/www/localhost/htdocs/installed