FROM php:7.0-stretch

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli pdo pdo_mysql

# Install Composer from official docker installation. Using last Composer image running PHP 7.
COPY --from=composer@sha256:d374b2e1f715621e9d9929575d6b35b11cf4a6dc237d4a08f2e6d1611f534675 /usr/bin/composer /usr/bin/composer

RUN debconf-set-selections << 'mysql-server mysql-server/root_password password bgawb'
RUN debconf-set-selections << 'mysql-server mysql-server/root_password_again password bgawb'
RUN apt-get update && apt-get install -y mysql-server
