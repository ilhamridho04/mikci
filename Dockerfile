FROM php:7.4-fpm

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-install pdo_mysql mysqli gd zip

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy CodeIgniter application files
COPY mikci/ /var/www/html/

# Install phpMyAdmin
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.tar.gz && \
    tar -xzf phpMyAdmin-5.1.1-all-languages.tar.gz && \
    rm phpMyAdmin-5.1.1-all-languages.tar.gz && \
    mv phpMyAdmin-5.1.1-all-languages /var/www/html/phpmyadmin

# Copy phpMyAdmin configuration file
COPY phpmyadmin/config.inc.php /var/www/html/phpmyadmin/

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=mikci
ENV MYSQL_USER=mikci_user
ENV MYSQL_PASSWORD=mikci_password

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server && \
    rm -rf /var/lib/mysql && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /etc/mysql/

# Copy my.cnf file for MySQL configuration
COPY mysql/my.cnf /etc/mysql/my.cnf

# Initialize MariaDB database
RUN service mysql start && mysql -u root -e "CREATE DATABASE mikci; GRANT ALL PRIVILEGES ON mikci.* TO 'mikci_user'@'localhost' IDENTIFIED BY 'mikci_password'; FLUSH PRIVILEGES;"

# Expose ports
EXPOSE 80
EXPOSE 3306

# Start services
CMD service nginx start && service mysql start && php-fpm
