# nginx

nginx, running on Alpine Linux and built from source with openssl 3, and several additional modules.

## Usage

Use this as a base image, and add your content to `/etc/nginx/html`, or write a custom nginx config to `/etc/nginx/conf.d/*.conf` and it will be included.

```bash
docker run --rm -it -p 80:80 cmoore1776/nginx:latest
```

```bash
$ curl -sSL -D - http://localhost -o /dev/null | head -n 2
HTTP/1.1 200 OK
Server: nginx/1.25.0
```

## Modules

The following modules are included for your convenience:

- ngx_http_brotli_filter_module
- ngx_http_brotli_static_module
- ngx_http_geoip_module
- ngx_http_headers_more_filter_module
- ngx_http_image_filter_module
- ngx_http_perl_module
- ngx_http_xslt_filter_module
- ngx_http_fancyindex_module
- ngx_mail_module
- ngx_stream_module
- ngx_stream_geoip_module

## Version info

```bash
$ docker run --rm -it cmoore1776/nginx:latest nginx -V
nginx version: nginx/1.25.0
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
built with OpenSSL 3.1.1 30 May 2023
TLS SNI support enabled
configure arguments:
--prefix=/etc/nginx
--sbin-path=/usr/sbin/nginx
--modules-path=/usr/lib/nginx/modules
--conf-path=/etc/nginx/nginx.conf
--error-log-path=/var/log/nginx/error.log
--http-log-path=/var/log/nginx/access.log
--pid-path=/var/run/nginx.pid
--lock-path=/var/run/nginx.lock
--http-client-body-temp-path=/var/cache/nginx/client_temp
--http-proxy-temp-path=/var/cache/nginx/proxy_temp
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp
--http-scgi-temp-path=/var/cache/nginx/scgi_temp
--user=nginx
--group=nginx
--with-select_module
--with-poll_module
--with-threads
--with-file-aio
--with-http_ssl_module
--with-http_v2_module
--with-http_realip_module
--with-http_addition_module
--with-http_xslt_module=dynamic
--with-http_image_filter_module=dynamic
--with-http_geoip_module=dynamic
--with-http_sub_module
--with-http_dav_module
--with-http_flv_module
--with-http_mp4_module
--with-http_gunzip_module
--with-http_gzip_static_module
--with-http_auth_request_module
--with-http_random_index_module
--with-http_secure_link_module
--with-http_degradation_module
--with-http_slice_module
--with-http_stub_status_module
--with-http_perl_module=dynamic
--with-perl_modules_path=/usr/share/perl/5.26.1
--with-perl=/usr/bin/perl
--http-log-path=/var/log/nginx/access.log
--http-client-body-temp-path=/var/cache/nginx/client_temp
--http-proxy-temp-path=/var/cache/nginx/proxy_temp
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp
--http-scgi-temp-path=/var/cache/nginx/scgi_temp
--with-mail=dynamic
--with-mail_ssl_module
--with-stream=dynamic
--with-stream_ssl_module
--with-stream_realip_module
--with-stream_geoip_module=dynamic
--with-stream_ssl_preread_module
--with-compat
--with-pcre=/build/pcre
--with-zlib=/build/zlib
--with-openssl=/build/openssl
--with-openssl-opt=no-nextprotoneg
--add-dynamic-module=/build/ngx_brotli
--add-dynamic-module=/build/headers-more
--add-dynamic-module=/build/ngx-fancyindex --with-debug
```

## build

```bash
export VERSION=1.25.0
export SHA256=5ed44d45943272a4e8a5bcf4434237210f2de31b903fca5e381c1bbd7eee1e8c
export PCRE2_VERSION=10.42
export PCRE2_SHA256=c33b418e3b936ee3153de2c61cc638e7e4fe3156022a5c77d0711bcbb9d64f1f
export ZLIB_COMMIT_SHA=4e4e4c4fbdad9dd034d8f05e2312bf845f0d4d15
export OPENSSL_VERSION=3.1.1
export OPENSSL_SHA256=b3aa61334233b852b63ddb048df181177c2c659eb9d4376008118f9c08d07674

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --build-arg VERSION --build-arg SHA256 --build-arg PCRE2_VERSION --build-arg PCRE2_SHA256 --build-arg ZLIB_COMMIT_SHA --build-arg OPENSSL_VERSION --build-arg OPENSSL_SHA256 --build-arg MORE_HEADERS_COMMIT_SHA -t cmoore1776/nginx:latest -t cmoore1776/nginx:${VERSION} -t cmoore1776/nginx:${VERSION}-openssl-${OPENSSL_VERSION} --pull --push .
```
