# Base image
FROM ubuntu:20.04

# Update package lists
RUN apt-get update

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN apt-get install -y nginx php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-zip mysql-client

# Set working directory
WORKDIR /var/www/html

# Copy Codeigniter app
COPY . /var/www/html/

# Configure Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-available/default
RUN rm /etc/nginx/sites-enabled/default

# Configure PHP
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.4/fpm/php.ini

# Install PHPMyAdmin
RUN apt-get install -y phpmyadmin
RUN ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

# Expose ports
EXPOSE 80
EXPOSE 3306

# Start services
CMD service php7.4-fpm start && service nginx start && service mysql start && tail -f /dev/null
