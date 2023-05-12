# Menggunakan gambar Ubuntu sebagai dasar
FROM ubuntu:latest

ENV TZ=Asia/Jakarta
# Memperbarui paket dan menginstal perangkat lunak yang dibutuhkan
RUN apt-get update && apt-get install -y \
    nginx \
    mysql-server \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-xml \
    php-curl \
    php-zip \
    unzip \
    wget

# Menyalin konfigurasi Nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Menyalin kode CodeIgniter ke dalam container
COPY mikci /var/www/html/

# Menyalin PHPMyAdmin ke dalam container
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip && \
    unzip phpMyAdmin-5.1.1-all-languages.zip && \
    mv phpMyAdmin-5.1.1-all-languages /usr/share/nginx/html/phpmyadmin

# Menyalin konfigurasi PHPMyAdmin
COPY config/config.inc.php /usr/share/nginx/html/phpmyadmin/config.inc.php

# Menyalin konfigurasi MySQL
COPY config/my.cnf /etc/mysql/my.cnf

# Menyalin script startup
COPY script/startup.sh /usr/local/bin/startup.sh

# Memberikan hak akses pada script startup
RUN chmod +x /usr/local/bin/startup.sh

# Menambahkan port yang akan digunakan
EXPOSE 80
EXPOSE 3306

# Menjalankan script startup
CMD ["/usr/local/bin/startup.sh"]
