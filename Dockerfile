FROM alpine:3.10

RUN \
    # DNS problem workaround
    # https://github.com/gliderlabs/docker-alpine/issues/386
    printf "nameserver 8.8.8.8\nnameserver 9.9.9.9\nnameserver 1.1.1.1" > /etc/resolv.conf \
    \
    && apk add --no-cache \
        python3 \
        py3-cryptography \
        ca-certificates \
        libcap \
    \
    && adduser tgproxy -u 10000 -D \
    && chown -R tgproxy:tgproxy /home/tgproxy \
    \
    && setcap cap_net_bind_service=+ep /usr/bin/python3.7

USER tgproxy

WORKDIR /home/tgproxy/
