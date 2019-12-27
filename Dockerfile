FROM ubuntu:18.04

ENV \
  VERSION=1.17.7 \
  SHA256=b62756842807e5693b794e5d0ae289bd8ae5b098e66538b2a91eb80f25c591ff \
  PCRE_VERSION=8.43 \
  PCRE_SHA256=0b8e7465dc5e98c757cc3650a20a7843ee4c3edf50aaf60bb33fd879690d2c73 \
  ZLIB_VERSION=1.2.11 \
  ZLIB_SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1 \
  OPENSSL_VERSION=1.1.1d \
  OPENSSL_SHA256=1e3a91bc1f9dfce01af26026f856e064eab4c8ee0a8f457b5ae30b40b8b711f2

RUN \
  apt update && apt upgrade -y && apt install -y \
    build-essential \
    curl \
    libxml2-dev \
    libxslt1-dev \
    libgd-dev \
    libgeoip-dev \
    libperl-dev && \
  cd /usr/local/src/ && \
  curl https://nginx.org/download/nginx-${VERSION}.tar.gz -o nginx-${VERSION}.tar.gz && \
  sha256sum nginx-${VERSION}.tar.gz | grep ${SHA256} && \
  tar -xf nginx-${VERSION}.tar.gz && \
  curl https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.gz -o pcre-${PCRE_VERSION}.tar.gz && \
  sha256sum pcre-${PCRE_VERSION}.tar.gz | grep ${PCRE_SHA256} && \
  tar -xf pcre-${PCRE_VERSION}.tar.gz && \
  curl https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz -o zlib-${ZLIB_VERSION}.tar.gz && \
  sha256sum zlib-${ZLIB_VERSION}.tar.gz | grep ${ZLIB_SHA256} && \
  tar -xf zlib-${ZLIB_VERSION}.tar.gz && \
  curl https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -o openssl-${OPENSSL_VERSION}.tar.gz && \
  sha256sum openssl-${OPENSSL_VERSION}.tar.gz | grep ${OPENSSL_SHA256} && \
  tar -xf openssl-${OPENSSL_VERSION}.tar.gz && \
  cd /usr/local/src/nginx-${VERSION} && \
  cp ./man/nginx.8 /usr/share/man/man8 && \
  gzip /usr/share/man/man8/nginx.8 && \
  ./configure --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-select_module \
    --with-poll_module \
    --with-threads \
    --with-file-aio \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_xslt_module=dynamic \
    --with-http_image_filter_module=dynamic \
    --with-http_geoip_module=dynamic \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_auth_request_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_degradation_module \
    --with-http_slice_module \
    --with-http_stub_status_module \
    --with-http_perl_module=dynamic \
    --with-perl_modules_path=/usr/share/perl/5.26.1 \
    --with-perl=/usr/bin/perl \
    --http-log-path=/var/log/nginx/access.log \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --with-mail=dynamic \
    --with-mail_ssl_module \
    --with-stream=dynamic \
    --with-stream_ssl_module \
    --with-stream_realip_module \
    --with-stream_geoip_module=dynamic \
    --with-stream_ssl_preread_module \
    --with-compat \
    --with-pcre=../pcre-${PCRE_VERSION} \
    --with-pcre-jit \
    --with-zlib=../zlib-${ZLIB_VERSION} \
    --with-openssl=../openssl-${OPENSSL_VERSION} \
    --with-openssl-opt=no-nextprotoneg \
    --with-debug && \
  make && \
  make install && \
  ln -s /usr/lib/nginx/modules /etc/nginx/modules && \
  apt remove -y \
    build-essential \
    curl \
    libxml2-dev \
    libxslt1-dev \
    libgd-dev \
    libgeoip-dev \
    libperl-dev && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm /usr/local/src/nginx-${VERSION}.tar.gz && \
  rm -rf /usr/local/src/nginx-${VERSION}  && \
  rm /usr/local/src/pcre-${PCRE_VERSION}.tar.gz && \
  rm -rf /usr/local/src/pcre-${PCRE_VERSION}  && \
  rm /usr/local/src/zlib-${ZLIB_VERSION}.tar.gz && \
  rm -rf /usr/local/src/zlib-${ZLIB_VERSION}  && \
  rm /usr/local/src/openssl-${OPENSSL_VERSION}.tar.gz && \
  rm -rf /usr/local/src/openssl-${OPENSSL_VERSION}  && \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
  adduser \
  --system \
  --home /nonexistent \
  --shell /bin/false \
  --no-create-home \
  --disabled-login \
  --disabled-password \
  --gecos "nginx user" \
  --group \
  nginx && \
  mkdir -p /var/cache/nginx/client_temp \
    /var/cache/nginx/fastcgi_temp \
    /var/cache/nginx/proxy_temp \
    /var/cache/nginx/scgi_temp \
    /var/cache/nginx/uwsgi_temp && \
  chmod 700 /var/cache/nginx/* && \
  chown nginx:root /var/cache/nginx/*

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]