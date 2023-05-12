FROM ubuntu:18.04

# Set environment variables
ENV DB_NAME=mikci \
    DB_USER=root \
    DB_PASSWORD=mikci123 \
    PMA_ARBITRARY=1 \
    PMA_HOST=localhost \
    PMA_USER=root \
    PMA_PASSWORD=mikci123 \
    TERM=xterm

# Install dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        nginx \
        php-fpm \
        php-mysql \
        php-mbstring \
        php-xml \
        php-gd \
        php-zip \
        mysql-server \
        phpmyadmin \
        supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy Nginx configuration
COPY default.conf /etc/nginx/sites-available/default

# Copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80
EXPOSE 3306

# Start supervisor
CMD ["/usr/bin/supervisord", "-n"]
