# Set the base image
FROM nginx:latest

# Update packages and install necessary libraries
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    git \
    libmcrypt-dev \
    libicu-dev \
    libzip-dev \
    zip \
    unzip \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add custom NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create necessary directories for PHP-FPM
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Set working directory
WORKDIR /var/www/html

# Copy CodeIgniter app files to working directory
COPY . /var/www/html/

# Install dependencies
RUN composer install

# Set permissions for CodeIgniter files
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose ports
EXPOSE 80

# Start NGINX and PHP-FPM
CMD service php7.4-fpm start && nginx -g 'daemon off;'
