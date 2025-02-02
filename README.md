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
Server: nginx/1.27.3
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
nginx version: nginx/1.27.3
built by gcc 14.2.0 (Alpine 14.2.0) 
built with OpenSSL 3.4.0 22 Oct 2024
TLS SNI support enabled
```

## build

```bash
export VERSION=1.27.3
export SHA256=ba23a9568f442036b61cd0e29bd66a47b90634efa91e0b2cf2d719057a9b7903
export PCRE2_VERSION=10.44
export PCRE2_SHA256=86b9cb0aa3bcb7994faa88018292bc704cdbb708e785f7c74352ff6ea7d3175b
export ZLIB_COMMIT_SHA=e8626ac81fa87f9150a34aedc9045a32e88e0310
export OPENSSL_VERSION=3.4.0
export OPENSSL_SHA256=e15dda82fe2fe8139dc2ac21a36d4ca01d5313c75f99f46c4e8a27709b7294bf

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --build-arg VERSION --build-arg SHA256 --build-arg PCRE2_VERSION --build-arg PCRE2_SHA256 --build-arg ZLIB_COMMIT_SHA --build-arg OPENSSL_VERSION --build-arg OPENSSL_SHA256 --build-arg MORE_HEADERS_COMMIT_SHA -t cmoore1776/nginx:latest -t cmoore1776/nginx:${VERSION} -t cmoore1776/nginx:${VERSION}-openssl-${OPENSSL_VERSION} --pull --push .
```
