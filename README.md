# nginx

nginx, running on Alpine Linux and built from source with openssl 3, and several additional modules.

## Usage

Use this as a base image, and add your content to `/etc/nginx/html`, or write a custom nginx config to `/etc/nginx/conf.d/*.conf` and it will be included.

```bash
docker run
--rm -it -p 80:80 cmoore1776/nginx:latest
```

```bash
$ curl -sSL -D - http://localhost -o /dev/null | head -n 2
HTTP/1.1 200 OK
Server: nginx/1.25.3
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
$ docker run --rm cmoore1776/nginx:latest nginx -V
nginx version: nginx/1.25.3
built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10) 
built with OpenSSL 3.2.0 23 Nov 2023
TLS SNI support enabled
```

## build

```bash
export VERSION=1.25.3
export SHA256=64c5b975ca287939e828303fa857d22f142b251f17808dfe41733512d9cded86
export PCRE2_VERSION=10.42
export PCRE2_SHA256=c33b418e3b936ee3153de2c61cc638e7e4fe3156022a5c77d0711bcbb9d64f1f
export ZLIB_COMMIT_SHA=d20bdfcd0efbdd72cb9d857e098ceac1bad41432
export OPENSSL_VERSION=3.2.0
export OPENSSL_SHA256=14c826f07c7e433706fb5c69fa9e25dab95684844b4c962a2cf1bf183eb4690e

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --build-arg VERSION --build-arg SHA256 --build-arg PCRE2_VERSION --build-arg PCRE2_SHA256 --build-arg ZLIB_COMMIT_SHA --build-arg OPENSSL_VERSION --build-arg OPENSSL_SHA256 --build-arg MORE_HEADERS_COMMIT_SHA -t cmoore1776/nginx:latest -t cmoore1776/nginx:${VERSION} -t cmoore1776/nginx:${VERSION}-openssl-${OPENSSL_VERSION} --pull --push .
```
