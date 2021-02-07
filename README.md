# docker-alpine-tor-gw
Tor gateway packaged into a Docker container. 

## Configuration - defaults

This container provides:

* HTTP to Socks5 bridge on 8080/tcp
* Socks5 proxy on 9050/tcp
* DNS resolver on 53/udp
* Does not provide any Tor hidden services

`/etc/tor/torrc`:
 
```
SocksPort 0.0.0.0:9050 
DNSPort 0.0.0.0:53 
ExitPolicy reject *:*
```

**Usage:**

`$ docker run -d -p 9050:9050 -p 8080:8080 -p 53:53/udp tmiklas/alpine-tor-gw`

## Optional settings

Image tagged `0.4.3.5h` introduces HTTP to Socks5 bridge on port 8080/tcp. It is active by default, so all that is needed to expose it or use right away in container-to-container comms. This makes it trivial to use tools like `curl` or `wget` with Tor.

Image tagged `0.4.2.6` introduces some optional configuration parameters (available also in later versions), that **will NOT work** with older images:

* Ability to open `ControlPort` on 9051/tcp - disabled by default
* Ability to change `ExitPolicy` 

### Enabling ControlPort

To enable `ControlPort` you have to set authentication method - otherwise Tor will disable `ControlPort` automatically. 

Currently only password based authentication is supported and you can set password by defining `ControlPassword` environment variable (variable name is case sensitive).

**Example:**

`$ docker run -d -p 9050:9050 -p 53:53/udp -p 9051:9051 -e ControlPassword=testpassword tmiklas/alpine-tor-gw`

### Changing ExitPolicy

As with `ControlPort`, changing default exit policy is done via `ExitPolicy` environment variable. 

Please read the Tor documentation before changing exit policies!

**Example:**

`$ docker run -d -p 9050:9050 -p 53:53/udp -p 9051:9051 -e ExitPolicy="reject *:25" tmiklas/alpine-tor-gw`

## Build information

* Base OS: Alpine LATEST (auto-rebuild on base image change - should always be current)
* Tor version: [0.4.4.7](https://dist.torproject.org/tor-0.4.4.7.tar.gz) compiled from source
* Image exposed ports: 
	* 8080/tcp
	* 9050/tcp 
	* 9051/tcp
	* 53/udp


EOT
