FROM php:7.4

RUN useradd -u 1000 -d /home/nitool -ms /bin/bash nitool
RUN chown -R nitool /home/nitool
RUN apt-get update && apt-get install -qq git ctags zip unzip libxml2-dev wget
RUN docker-php-ext-install soap
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '$(wget -q -O - https://composer.github.io/installer.sig)') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && cp composer.phar /usr/bin/composer

USER nitool

