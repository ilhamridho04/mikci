FROM nginx:latest

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-json \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY default.conf /etc/nginx/conf.d/

WORKDIR /var/www/html

COPY . .

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 775 /var/www/html/application/cache && \
    chmod -R 775 /var/www/html/application/logs && \
    chmod -R 775 /var/www/html/uploads && \
    chmod -R 775 /var/www/html/assets && \
    chmod -R 775 /var/www/html/.git

RUN composer install

RUN mkdir -p /var/www/session && \
    chown -R www-data:www-data /var/www/session && \
    chmod -R 775 /var/www/session

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
