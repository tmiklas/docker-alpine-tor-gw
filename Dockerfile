FROM alpine:3.9
MAINTAINER @tomaszmiklas
RUN apk add --no-cache ca-certificates gcc build-base libevent-dev openssl-dev tar wget zlib-dev xz-dev xz-libs && \
cd /tmp && \
wget -q https://dist.torproject.org/tor-0.4.2.5.tar.gz && \
tar zxf tor-0.4.2.5.tar.gz && \
cd tor-0.4.2.5 && \
./configure && \
make && \
make install && \
apk del --no-cache ca-certificates gcc build-base libevent-dev openssl-dev tar wget zlib-dev xz-dev&& \
apk add --no-cache libevent && \
rm -rf /tmp/* && \
mkdir /etc/tor && \
echo SocksPort 0.0.0.0:9050 > /etc/tor/torrc && \
echo DNSPort 0.0.0.0:53 >> /etc/tor/torrc && \
echo ExitPolicy reject *:* >> /etc/tor/torrc
EXPOSE 9050 53/udp
ENTRYPOINT ["/usr/local/bin/tor","-f","/etc/tor/torrc"]
