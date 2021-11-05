FROM alpine:3.14

ARG VERSION SHA256 PCRE_VERSION PCRE_SHA256 ZLIB_COMMIT ZLIB_SHA256 OPENSSL_VERSION OPENSSL_SHA256 MORE_HEADERS_VERSION MORE_HEADERS_SHA256

RUN \
  apk update && \
  apk upgrade && \
  apk add \
    alpine-sdk \
    curl \
    gd-dev \
    geoip-dev \
    git \
    gzip \
    libgd \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    perl \
    perl-dev \
    zlib-dev \
  && \
  mkdir -p /usr/local/src && \
  mkdir -p /usr/share/man/man8 && \
  cd /usr/local/src/ && \
  curl -L https://nginx.org/download/nginx-${VERSION}.tar.gz -o nginx-${VERSION}.tar.gz && \
  sha256sum nginx-${VERSION}.tar.gz | grep ${SHA256} && \
  tar -xf nginx-${VERSION}.tar.gz && \
  curl -L https://phoenixnap.dl.sourceforge.net/project/pcre/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.gz -o pcre-${PCRE_VERSION}.tar.gz && \
  sha256sum pcre-${PCRE_VERSION}.tar.gz | grep ${PCRE_SHA256} && \
  mkdir -p /build/pcre && \
  tar -xf pcre-${PCRE_VERSION}.tar.gz --strip-components=1 -C /build/pcre && \
  curl -L https://api.github.com/repos/cloudflare/zlib/tarball/${ZLIB_COMMIT} -o zlib.tar.gz && \
  sha256sum zlib.tar.gz | grep ${ZLIB_SHA256} && \
  mkdir -p /build/zlib && \
  tar -xf zlib.tar.gz --strip-components=1 -C /build/zlib && \
  cd /build/zlib && \
  ./configure && \
  cd /usr/local/src/ && \
  curl -L https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -o openssl-${OPENSSL_VERSION}.tar.gz && \
  sha256sum openssl-${OPENSSL_VERSION}.tar.gz | grep ${OPENSSL_SHA256} && \
  mkdir -p /build/openssl && \
  tar -xf openssl-${OPENSSL_VERSION}.tar.gz --strip-components=1 -C /build/openssl && \
  git clone --depth 1 --single-branch --recursive https://github.com/google/ngx_brotli.git /build/ngx_brotli && \
  curl -L https://github.com/openresty/headers-more-nginx-module/archive/refs/tags/v${MORE_HEADERS_VERSION}.tar.gz -o headers-more-nginx-module-${MORE_HEADERS_VERSION}.tar.gz && \
  sha256sum headers-more-nginx-module-${MORE_HEADERS_VERSION}.tar.gz | grep ${MORE_HEADERS_SHA256} && \
  mkdir -p /build/headers-more && \
  tar -zxf headers-more-nginx-module-${MORE_HEADERS_VERSION}.tar.gz --strip-components=1 -C /build/headers-more && \
  cd /usr/local/src/nginx-${VERSION} && \
  cp ./man/nginx.8 /usr/share/man/man8 && \
  gzip /usr/share/man/man8/nginx.8 && \
  mkdir -p /var/cache/nginx && \
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
    --with-pcre=/build/pcre \
    --with-pcre-jit \
    --with-zlib=/build/zlib \
    --with-openssl=/build/openssl \
    --with-openssl-opt=no-nextprotoneg \
    --add-dynamic-module=/build/ngx_brotli \
    --add-dynamic-module=/build/headers-more \
    --with-debug && \
  make && \
  make install && \
  ln -s /usr/lib/nginx/modules /etc/nginx/modules && \
  apk del \
    alpine-sdk \
    curl \
    gd-dev \
    geoip-dev \
    git \
    gzip \
    libgd \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    perl \
    perl-dev \
    zlib-dev \
  && \
  cd / && \
  rm -rf /var/cache/apk/* && \
  rm /usr/local/src/nginx-${VERSION}.tar.gz && \
  rm -rf /usr/local/src/nginx-${VERSION}  && \
  rm -rf /build  && \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
  adduser -D -g nginx nginx && \
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