FROM alpine:latest
MAINTAINER @tomaszmiklas
RUN apk add --no-cache ca-certificates gcc build-base libevent-dev openssl-dev tar wget zlib-dev xz-dev xz-libs bash py3-pip && \
pip3 install pproxy && \
cd /tmp && \
wget -q https://dist.torproject.org/tor-0.4.3.6.tar.gz && \
tar zxf tor-0.4.3.6.tar.gz && \
cd tor-0.4.3.6 && \
./configure && \
make && \
make install && \
apk del --no-cache ca-certificates gcc build-base libevent-dev openssl-dev tar wget zlib-dev xz-dev&& \
apk add --no-cache libevent && \
rm -rf /tmp/*
ADD tor-init.sh /etc/tor/tor-init.sh
EXPOSE 8080 9050 9051 53/udp
ENTRYPOINT ["/etc/tor/tor-init.sh"]
