in_array() {
    local haystack=${1}[@]
    local needle=${2}
    for i in ${!haystack}; do
        if [[ ${i} == ${needle} ]]; then
            return 0
        fi
    done
    return 1
}

oldIFS=$IFS  #定义一个变量为默认IFS
IFS=,        #设置IFS为逗号
docker_install_ext_arr=("pdo_mysql" "mysqli" "mbstring" "curl" "opcache")

for ext in ${MY_PHP_EXTENSIONS}
do
    if in_array docker_install_ext_arr "${ext}"; then
        docker-php-ext-install ${ext}

    elif [[ ${ext} == "gd" ]]; then
        docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd

    elif [[ ${ext} == "memcached" ]]; then
        pecl install memcached-${MY_PHP_MEMCACHED_VERSION} && docker-php-ext-enable memcached

    elif [[ ${ext} == "redis" ]]; then
        pecl install memcached-${MY_PHP_MEMCACHED_VERSION} && docker-php-ext-enable memcached
    fi
done

IFS=$oldIFS  #还原IFS为默认值
