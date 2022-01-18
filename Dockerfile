FROM ghcr.io/linuxserver/baseimage-alpine-nginx:arm64v8-3.15-php8

# set version label
ARG LYCHEE_VERSION=

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    composer \
    git && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    curl \
    exiftool \
    ffmpeg \
    gd \
    imagemagick \
    jpegoptim \
    php8-bcmath \
    php8-ctype \
    php8-dom \
    php8-exif \
    php8-gd \
    php8-pecl-imagick \
    php8-intl \
    php8-json \
    php8-mbstring \
    php8-mysqli \
    php8-pdo_mysql \
    php8-session \
    php8-tokenizer \
    php8-xml \
    php8-zip && \
  echo "**** install lychee ****" && \
  mkdir -p /app/lychee && \
  if [ -z ${LYCHEE_VERSION} ]; then \
    LYCHEE_VERSION=$(curl -sX GET "https://api.github.com/repos/LycheeOrg/Lychee/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
    /tmp/lychee.tar.gz -L \
    "https://github.com/LycheeOrg/Lychee/archive/${LYCHEE_VERSION}.tar.gz" && \
  tar xf \
  /tmp/lychee.tar.gz -C \
    /app/lychee/ --strip-components=1 && \
  cd /app/lychee && \
  echo "**** install composer dependencies ****" && \
  composer install \
    -d /app/lychee \
    --no-dev \
    --no-suggest \
    --no-interaction && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /root/.cache \
    /tmp/*

# add local files
COPY root/ /
