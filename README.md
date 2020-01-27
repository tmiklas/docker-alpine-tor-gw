# docker-alpine-tor-gw
Tor gateway packaged into a Docker container. 

### Configuration

This container provides:

* Socks5 proxy on 9050/tcp
* DNS resolver on 53/udp
* Does not work as Exit node
* Does not provide any Tor hidden services

`/etc/tor/torrc`:
 
```
SocksPort 9050 
SocksBindAddress 0.0.0.0 
DNSPort 53 
DNSListenAddress 0.0.0.0
ExitPolicy reject *:*
```

### Build information

* Base OS: Alpine v3.9
* Tor version: [0.2.9.13](https://dist.torproject.org/tor-0.2.9.13.tar.gz) compiled from source


EOT
