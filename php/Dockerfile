ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm

# 设置参数
ARG PHP_EXTENSIONS
ARG PHP_MEMCACHED_VERSION
ARG PHP_REDIS_VERSION

# 替换软件源

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libpng-dev \
    libpcre3-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libz-dev \
    libmemcached-dev

ENV MY_PHP_EXTENSIONS=${PHP_EXTENSIONS}
ENV MY_PHP_MEMCACHED_VERSION=${PHP_MEMCACHED_VERSION}
ENV MY_PHP_REDIS_VERSION=${PHP_REDIS_VERSION}

COPY ./extensions /tmp/extensions

# 安装扩展
COPY ./install_extension.sh /tmp/install_extension.sh
RUN chmod +x /tmp/install_extension.sh && /bin/bash /tmp/install_extension.sh


