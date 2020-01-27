FROM alpine:3.9
MAINTAINER @tomaszmiklas
RUN apk add --no-cache ca-certificates gcc build-base libevent-dev openssl-dev tar wget zlib-dev && \
cd /tmp && \
wget -q https://dist.torproject.org/tor-0.2.9.13.tar.gz && \
tar zxf tor-0.2.9.13.tar.gz && \
cd tor-0.2.9.13 && \
./configure && \
make && \
make install && \
apk del --no-cache ca-certificates gcc build-base libevent-dev openssl-dev tar wget && \
apk add --no-cache libevent && \
rm -rf /tmp/* && \
mkdir /etc/tor && \
echo SocksPort 9050 > /etc/tor/torrc && \
echo SocksBindAddress 0.0.0.0 >> /etc/tor/torrc && \
echo DNSPort 53 >> /etc/tor/torrc && \
echo DNSListenAddress 0.0.0.0 >> /etc/tor/torrc && \
echo ExitPolicy reject *:* >> /etc/tor/torrc
EXPOSE 9050 53/udp
ENTRYPOINT ["/usr/local/bin/tor","-f","/etc/tor/torrc"]
