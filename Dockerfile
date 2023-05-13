# Gunakan base image Ubuntu 20.04
FROM ubuntu:20.04

# Install tzdata
ENV TZ=Asia/Jakarta
RUN apt-get update && \
    apt-get install -y tzdata

# Update package dan install dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    mysql-server \
    mysql-client \
    phpmyadmin \
    && rm -rf /var/lib/apt/lists/*

# Tambahkan file konfigurasi Apache dan PHP
COPY ./config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./config/php.ini /etc/php/7.4/apache2/php.ini

# Tambahkan file konfigurasi phpMyAdmin
COPY ./config/config.inc.php /etc/phpmyadmin/config.inc.php

# Buat direktori untuk aplikasi Codeigniter 3
RUN mkdir -p /var/www/html/mikci

# Salin kode aplikasi Codeigniter 3 ke dalam container
COPY mikci/ /var/www/html/mikci

# Atur izin akses pada direktori Codeigniter 3
RUN chown -R www-data:www-data /var/www/html/mikci
RUN chmod -R 755 /var/www/html/mikci

# Tambahkan skrip untuk memulai service Apache dan MySQL
COPY ./scripts/start.sh /start.sh
RUN chmod +x /start.sh

# Expose port 80 dan 3306
EXPOSE 80
EXPOSE 3306

# Jalankan skrip untuk memulai service Apache dan MySQL
CMD ["/start.sh"]
