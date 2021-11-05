# nginx

Dockerfile for nginx, based on Alpine Linux and built from source with openssl 1.1.1 (supports TLSv1.3).

## Usage

Use this as a base image, and add your content to `/etc/nginx/html`, or write a custom nginx config to `/etc/nginx/nginx.conf`.

```bash
docker run --rm -it -p 80:80 shamelesscookie/nginx:latest
```

```bash
$ curl -sSL -D - http://localhost -o /dev/null | head -n 2
HTTP/1.1 200 OK
Server: nginx/1.21.1
```

### Version info

```bash
$ docker run --rm -it shamelesscookie/nginx:latest nginx -V
nginx version: nginx/1.21.4
built by gcc 10.3.1 20210424 (Alpine 10.3.1_git20210424) 
built with OpenSSL 3.0.0 7 sep 2021
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-perl_modules_path=/usr/share/perl/5.26.1 --with-perl=/usr/bin/perl --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module=dynamic --with-stream_ssl_preread_module --with-compat --with-pcre=/build/pcre --with-pcre-jit --with-zlib=/build/zlib --with-openssl=/build/openssl --with-openssl-opt=no-nextprotoneg --add-dynamic-module=/build/ngx_brotli --add-dynamic-module=/build/headers-more --with-debug
```

## build

```bash
export VERSION=1.21.4
export SHA256=d1f72f474e71bcaaf465dcc7e6f7b6a4705e4b1ed95c581af31df697551f3bfe
export PCRE_VERSION=8.45
export PCRE_SHA256=4e6ce03e0336e8b4a3d6c2b70b1c5e18590a5673a98186da90d4f33c23defc09
export ZLIB_COMMIT=959b4ea305821e753385e873ec4edfaa9a5d49b7
export ZLIB_SHA256=9d7e1022cbd53c43cff045a5a1c52f961b908bd94d9cc7d3dab4dea71e408e8c
export OPENSSL_VERSION=3.0.0
export OPENSSL_SHA256=59eedfcb46c25214c9bd37ed6078297b4df01d012267fe9e9eee31f61bc70536
export MORE_HEADERS_VERSION=0.33
export MORE_HEADERS_SHA256=a3dcbab117a9c103bc1ea5200fc00a7b7d2af97ff7fd525f16f8ac2632e30fbf

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --build-arg VERSION --build-arg SHA256 --build-arg PCRE_VERSION --build-arg PCRE_SHA256 --build-arg ZLIB_COMMIT --build-arg ZLIB_SHA256 --build-arg OPENSSL_VERSION --build-arg OPENSSL_SHA256 --build-arg MORE_HEADERS_VERSION --build-arg MORE_HEADERS_SHA256 -t shamelesscookie/nginx:latest -t shamelesscookie/nginx:${VERSION} -t shamelesscookie/nginx:${VERSION}-openssl-${OPENSSL_VERSION} --pull --push .
```