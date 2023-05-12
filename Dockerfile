# menggunakan image base Ubuntu
FROM ubuntu:latest

# mengupdate repository Ubuntu dan menginstall paket-paket yang dibutuhkan
RUN apt-get update && \
    apt-get install -y nginx php7.4 php7.4-fpm php7.4-mysql php7.4-gd php7.4-mbstring php7.4-xml mysql-server phpmyadmin supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# menyalin file konfigurasi Nginx ke dalam container
COPY nginx.conf /etc/nginx/sites-available/default

# menyalin file konfigurasi Supervisor ke dalam container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# membuat direktori untuk CodeIgniter
RUN mkdir -p /var/www/html

# menyalin file CodeIgniter ke dalam direktori /var/www/html
COPY mikci /var/www/html

# menyalin file konfigurasi PHPMyAdmin ke dalam direktori /etc/phpmyadmin
COPY phpmyadmin/config.inc.php /etc/phpmyadmin/config.inc.php

# menyalin file konfigurasi MySQL ke dalam direktori /etc/mysql
COPY mysql/my.cnf /etc/mysql/my.cnf

# mengekspose port 80 dan 443
EXPOSE 80
EXPOSE 443

# menjalankan Nginx dan Supervisor pada saat container dijalankan
CMD ["/usr/bin/supervisord"]
