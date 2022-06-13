!#/bin/sh

mysql_install_db --user=root --datadir=/var/lib/mysql
mysqld --user=root --bootstrap < /etc/mysql.sql
mysqld --user=root --bootstrap < /etc/phpmyadmin.sql