FROM php:7.4-fpm

WORKDIR /var/www/html

# Instalacao das dependências necessárias
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    sendmail \
    libzip-dev \
    libonig-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/freetype2 --with-jpeg=/usr/include \
    && docker-php-ext-install gd

# Instalacao de outras extensões do PHP
RUN docker-php-ext-install zip pdo pdo_mysql mysqli mbstring

# Limpeza do cache do apt para manter a imagem mais leve
RUN apt-get clean && rm -rf /var/lib/apt/lists/*