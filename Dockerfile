##
## simpleproxy
##

## Use latest Alpine based images as starting point
FROM alpine

ENV UID=1000 GID=1000

## Choose between branches
ARG BRANCH=master

COPY entrypoint.sh /

RUN apk add --no-cache shadow build-base gcc abuild binutils binutils-doc gcc-doc git libev-dev automake autoconf libtool argp-standalone cmake cmake-doc dev86 \
    && mkdir -p /usr/local/src && cd /usr/local/src \
    && git clone https://github.com/vzaliva/simpleproxy.git --single-branch --branch $BRANCH \
    && cd ./simpleproxy \
    && ./configure \
    && mkdir -p src/include/sys && ln -s /usr/lib/bcc/include/sys/cdefs.h src/include/sys \
    && make && make install && cd .. && rm -rf simpleproxy \
    && addgroup -S simpleproxy --gid $GID \
    && adduser -D -S -s /bin/sh --uid $UID -G simpleproxy simpleproxy \
    && chmod a+x /entrypoint.sh \
    && apk del --no-cache shadow build-base gcc abuild binutils binutils-doc gcc-doc git libev-dev automake autoconf libtool argp-standalone cmake cmake-doc dev86

ENTRYPOINT ["/entrypoint.sh"]
