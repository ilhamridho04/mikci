# Base image
FROM php:7.4-fpm

# Install required extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Copy nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy codeigniter files to the nginx document root
COPY . /var/www/html/

# Install phpMyAdmin
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.tar.gz && \
    tar -xzf phpMyAdmin-5.1.1-all-languages.tar.gz && \
    rm phpMyAdmin-5.1.1-all-languages.tar.gz && \
    mv phpMyAdmin-5.1.1-all-languages /var/www/html/phpmyadmin

# Copy phpMyAdmin configuration file
COPY phpmyadmin/config.inc.php /var/www/html/phpmyadmin/

# Install MySQL
RUN apt-get update && \
    apt-get install -y mysql-server

# Copy MySQL configuration file
COPY mysql/my.cnf /etc/mysql/my.cnf

# Expose ports
EXPOSE 80
EXPOSE 3306

# Start nginx and MySQL services
CMD service nginx start && service mysql start && tail -f /dev/null
