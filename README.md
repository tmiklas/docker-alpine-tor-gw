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
SocksPort 0.0.0.0:9050 
DNSPort 0.0.0.0:53 
ExitPolicy reject *:*
```

### Build information

* Base OS: Alpine v3.9
* Tor version: [0.4.2.5](https://dist.torproject.org/tor-0.4.2.5.tar.gz) compiled from source


EOT
