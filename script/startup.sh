#!/bin/bash

# Memulai MySQL
service mysql start

# Mengatur password root MySQL
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES;"

# Mengaktifkan PHP-FPM dan Nginx
service php7.4-fpm start
service nginx start

# Menjaga container tetap berjalan
tail -f /dev/null
