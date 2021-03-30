
ARG distribution=""
ARG release=""
ARG codename=""
ARG variant=""
ARG php_version=""

FROM php:${php_version:+${php_version}-}${variant:+${variant}-}${codename:+${codename}}

LABEL MAINTAINER="Rodrigo Cabral <rodrixcornell@gmail.com.br>"

ENV TIMEZONE="America/Manaus" \
  LC_ALL="C.UTF-8" \
  LANG="pt_BR.utf8" \
  LANGUAGE="pt_BR:pt"

RUN set -xe \
  && curl -ksSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && echo $TIMEZONE | tee /etc/timezone \
  && apt-get update -y && apt-get upgrade -yq --no-install-recommends \
  && apt-get install -y --no-install-recommends git locales software-properties-common \
  && localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8 \
  && locale-gen pt_BR.UTF-8 \
  && apt-get install -y --no-install-recommends \
  libfreetype6-dev \
  libjpeg-dev \
  libpng-dev \
  libzip-dev \
  libbz2-dev \
  libmcrypt-dev \
  libicu-dev \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  \
  && docker-php-source extract \
  && docker-php-ext-configure gd --with-freetype --with-jpeg --enable-gd-native-ttf \
  && docker-php-ext-configure zip \
  && docker-php-ext-configure bz2 --with-bz2 \
  && docker-php-ext-configure mcrypt \
  && docker-php-ext-configure intl \
  && docker-php-ext-install -j$(nproc) gd zip bz2 mcrypt intl bcmath exif mysqli pdo_mysql \
  && docker-php-ext-enable gd zip bz2 mcrypt intl bcmath exif mysqli pdo_mysql \
  && docker-php-source delete \
  && apt-get purge -y locales software-properties-common && apt-get autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && rm -rf /usr/lib/python3 \
  && apt-get update -y && apt-get upgrade -yq --no-install-recommends && apt-get autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Use the default production configuration
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# Override with custom mysql settings
# COPY config/mysql.ini $PHP_INI_DIR/conf.d/
# COPY config/pdo_mysql.ini $PHP_INI_DIR/conf.d/
