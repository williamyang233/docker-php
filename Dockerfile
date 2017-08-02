#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM daocloud.io/library/php:7.1.4-fpm

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

RUN apt-get update
RUN docker-php-ext-install iconv mysqli pdo pdo_mysql

RUN apt-get -y install libmcrypt-dev libpng-dev zlib1g-dev libjpeg62-turbo-dev libfreetype6-dev libcurl4-gnutls-dev libbz2-dev sendmail --no-install-recommends

RUN docker-php-ext-install mcrypt curl bz2 gd zip

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN pecl install redis && docker-php-ext-enable redis

EXPOSE 9000
CMD ["php-fpm"]