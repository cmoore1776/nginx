# nginx

nginx, based on Alpine Linux and built from source with openssl 3.

## Usage

Use this as a base image, and add your content to `/etc/nginx/html`, or write a custom nginx config to `/etc/nginx/nginx.conf`.

```bash
docker run --rm -it -p 80:80 shamelesscookie/nginx:latest
```

```bash
$ curl -sSL -D - http://localhost -o /dev/null | head -n 2
HTTP/1.1 200 OK
Server: nginx/1.23.2
```

### Version info

```bash
$ docker run --rm -it shamelesscookie/nginx:latest nginx -V
nginx version: nginx/1.23.2
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
built with OpenSSL 3.0.7 1 Nov 2022
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-perl_modules_path=/usr/share/perl/5.26.1 --with-perl=/usr/bin/perl --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module=dynamic --with-stream_ssl_preread_module --with-compat --with-pcre=/build/pcre --with-zlib=/build/zlib --with-openssl=/build/openssl --with-openssl-opt=no-nextprotoneg --add-dynamic-module=/build/ngx_brotli --add-dynamic-module=/build/headers-more --with-debug
```

## build

```bash
export VERSION=1.23.2
export SHA256=a80cc272d3d72aaee70aa8b517b4862a635c0256790434dbfc4d618a999b0b46
export PCRE2_VERSION=10.41
export PCRE2_SHA256=d188f77c239efb0ca192ba7bed109cd307fb205f4b2ad8343c4f69c9079e0371
export ZLIB_COMMIT_SHA=885674026394870b7e7a05b7bf1ec5eb7bd8a9c0
export OPENSSL_VERSION=3.0.7
export OPENSSL_SHA256=83049d042a260e696f62406ac5c08bf706fd84383f945cf21bd61e9ed95c396e
export MORE_HEADERS_COMMIT_SHA=33b646d69f39604d71342ee241633975aa122b35

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --build-arg VERSION --build-arg SHA256 --build-arg PCRE2_VERSION --build-arg PCRE2_SHA256 --build-arg ZLIB_COMMIT_SHA --build-arg OPENSSL_VERSION --build-arg OPENSSL_SHA256 --build-arg MORE_HEADERS_COMMIT_SHA -t shamelesscookie/nginx:latest -t shamelesscookie/nginx:${VERSION} -t shamelesscookie/nginx:${VERSION}-openssl-${OPENSSL_VERSION} --pull --push .
```