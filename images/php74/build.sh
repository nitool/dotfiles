#!/bin/bash

docker image build -t local_php74 -<<EOF
FROM php:7.4

RUN useradd -u ${UID} -d /home/${USER} -ms /bin/bash ${USER}
RUN chown -R ${USER} /home/${USER}
RUN apt-get update && apt-get install -qq git ctags zip unzip libxml2-dev wget
RUN docker-php-ext-install soap
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '$(wget -q -O - https://composer.github.io/installer.sig)') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && cp composer.phar /usr/bin/composer

USER ${USER}
EOF