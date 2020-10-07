FROM php:7-apache
LABEL maintainer="Arvin Atienza <arvin.atienza@gmail.com>"

ARG USER_ID=33
ARG GROUP_ID=33

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update \
    && apt-get install -y \
      git \
      libxml2-dev \
      unzip \
      wget \
      zip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '795f976fe0ebd8b75f26a6dd68f78fd3453ce79f32ecb33e7fd087d39bfeb978342fb73ac986cd4f54edd0dc902601dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
#RUN php -r "copy('https://getcomposer.org/download/1.10.13/composer.phar', 'composer-setup.php');" \
    #&& php -r "if (hash_file('sha256', 'composer-setup.php') === '5ca7445cfd48dd27c5a84aa005a47b4d9fd91132313830609875df3a6973708f') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    #&& php composer-setup.php --install-dir=/bin --filename=composer \
    #&& php -r "unlink('composer-setup.php');"

RUN docker-php-ext-install \
      bcmath \
      ctype \
      fileinfo \
      json \
      pdo \
      pdo_mysql \
      tokenizer \
      xml

# Make www-data the default user
RUN usermod -u ${USER_ID} www-data \
    && groupmod -g ${GROUP_ID} www-data \
    && mkdir -p /home/www-data \
    && chown www-data:www-data /home/www-data \
    && usermod -d /home/www-data www-data

# Update apache settings
RUN sed -i 's/www\/html/www\/html\/public/' /etc/apache2/sites-enabled/000-default.conf

# Update user settings
WORKDIR "/var/www/html"
ADD --chown=www-data:www-data . ./

RUN composer install \
    && chown www-data:www-data -R .

EXPOSE 80
EXPOSE 8000
