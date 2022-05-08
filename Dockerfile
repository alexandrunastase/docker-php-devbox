FROM php:8.1-fpm-alpine

LABEL maintainer="alexandrunastase@github"
LABEL description="Devbox Docker image"

# User build args
ARG APP_ENV="prod"
ARG APP_DEBUG="0"
ARG APP_LOG="php://stdout"

# Environment variables
ENV APP_ENV=${APP_ENV}
ENV APP_DEBUG=${APP_DEBUG}
ENV APP_LOG=${APP_LOG}

ENV XDEBUG_CONFIG=""
ENV COMPOSER_NO_INTERACTION=1

# Add PHP user
ARG PHP_USER_ID=1000
ARG PHP_GROUP_ID=1000
RUN set -x \
    && addgroup -g $PHP_GROUP_ID -S php \
    && adduser -u $PHP_USER_ID -D -S -G php php

# Install dependencies
RUN set -ex \
    && docker-php-source extract \
    && apk add --update --no-cache \
    ${PHPIZE_DEPS} \
    curl \
    # Runtime deps
    icu-dev icu-libs \
    libzip-dev zlib-dev \
    libxml2-dev \
    oniguruma-dev \
    && pecl install xdebug \
    && docker-php-ext-install intl opcache pdo_mysql zip bcmath mbstring sockets pcntl soap sockets ctype > /dev/null \
    && docker-php-ext-enable intl opcache pdo_mysql zip bcmath mbstring sockets pcntl soap sockets ctype \
    && apk del ${PHPIZE_DEPS} \
    && docker-php-source delete

# Copy configuration files
COPY ./docker/service/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./docker/service/php.ini $PHP_INI_DIR/conf.d/99-app.ini
COPY ./docker/service/xdebug.ini $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY --chown=php . /app

WORKDIR /app

USER php
