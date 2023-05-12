FROM ubuntu:latest

# Install Nginx
RUN apt-get update && \
    apt-get install -y nginx
    
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP-FPM
RUN apt-get install -y php-fpm

# Install MySQL Server
RUN apt-get install -y mysql-server

# Install phpMyAdmin
RUN apt-get install -y phpmyadmin

# Add CodeIgniter app to container
ADD codeigniter-app /var/www/html/

# Add Nginx configuration file to container
ADD nginx.conf /etc/nginx/nginx.conf

# Start all services
CMD service mysql start && \
    service php7.4-fpm start && \
    nginx -g 'daemon off;'
