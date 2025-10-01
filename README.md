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
Server: nginx/1.29.1
```

## Modules

The following modules are included for your convenience:

- ngx_http_brotli_filter_module
- ngx_http_brotli_static_module
- ngx_http_fancyindex_module
- ngx_http_geoip_module
- ngx_http_headers_more_filter_module
- ngx_http_image_filter_module
- ngx_http_js_module
- ngx_http_perl_module
- ngx_http_xslt_filter_module
- ngx_mail_module
- ngx_stream_module
- ngx_stream_geoip_module

## Version info

```bash
$ docker run --rm cmoore1776/nginx:latest nginx -V
nginx version: nginx/1.29.1
built by gcc 14.2.0 (Alpine 14.2.0) 
built with OpenSSL 3.5.4 30 Sep 2025
TLS SNI support enabled
```

## build

```bash
export VERSION=1.29.1
export SHA256=c589f7e7ed801ddbd904afbf3de26ae24eb0cce27c7717a2e94df7fb12d6ad27
export PCRE2_VERSION=10.46
export PCRE2_SHA256=8d28d7f2c3b970c3a4bf3776bcbb5adfc923183ce74bc8df1ebaad8c1985bd07
export ZLIB_COMMIT_SHA=1252e2565573fe150897c9d8b44d3453396575ff
export OPENSSL_VERSION=3.5.4
export OPENSSL_SHA256=967311f84955316969bdb1d8d4b983718ef42338639c621ec4c34fddef355e99

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --build-arg VERSION --build-arg SHA256 --build-arg PCRE2_VERSION --build-arg PCRE2_SHA256 --build-arg ZLIB_COMMIT_SHA --build-arg OPENSSL_VERSION --build-arg OPENSSL_SHA256 --build-arg MORE_HEADERS_COMMIT_SHA -t cmoore1776/nginx:latest -t cmoore1776/nginx:${VERSION} -t cmoore1776/nginx:${VERSION}-openssl-${OPENSSL_VERSION} --pull --push .
```
