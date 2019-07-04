FROM php:7.1-fpm
LABEL MAINTAINER="Mervyn"

RUN groupadd -f www
RUN useradd -g www www

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install -y --allow-downgrades \
	libpng-dev \
    libpcre3=2:8.35-3.3+deb8u4 \
	libpcre3-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libsasl2-2=2.1.26.dfsg1-13+deb8u1 \
    zlib1g=1:1.2.8.dfsg-2+b1 \
    libsasl2-dev \
    libz-dev libmemcached-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install zip

RUN apt-get install -y git
RUN git clone https://github.com/nikic/php-ast.git \
    && cd php-ast \
    && phpize \
    && ./configure \
    && make install \
    && echo 'extension=ast.so' > /usr/local/etc/php/php.ini \
    && cd .. && rm -rf php-ast

RUN apt-get install -y procps
RUN apt-get install -y vim
# RUN docker-php-ext-install MongoClient

COPY ext /tmp

ENV PHPREDIS_VERSION 3.1.2
RUN tar xfz /tmp/phpredis-$PHPREDIS_VERSION.tar.gz \
    && rm -r /tmp/phpredis-$PHPREDIS_VERSION.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php

RUN mv /tmp/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

