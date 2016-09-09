FROM ubuntu:16.04

MAINTAINER "Giovanni Colapinto" alfheim@syshell.net

RUN apt-get update \
    && apt-get install -y --no-install-recommends --fix-missing \
    apache2 \
    sudo \
    supervisor \
    php7.0 \
    php7.0-bcmath \
    php7.0-calendar \
    php7.0-cli \
    php7.0-curl \
    php7.0-gd \
    php7.0-iconv \
    php7.0-json \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-mysqli \
    php7.0-mysqlnd \
    php7.0-opcache \
    php7.0-pdo \
    php7.0-pdo-mysql \
    php7.0-soap \
    php7.0-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV APACHE_RUN_USER www-data 
ENV APACHE_RUN_GROUP www-data 
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80 

# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
CMD ["/usr/bin/supervisord"]
