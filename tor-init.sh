#!/bin/bash
#
# generate intial torrc file
#

if [ ! -f /etc/tor/torrc ]; then

	echo SocksPort 0.0.0.0:9050 > /etc/tor/torrc
	echo DNSPort 0.0.0.0:53 >> /etc/tor/torrc

	# control port settings
	if [ ! -z ${ControlPassword} ]; then
		echo ControlPort 0.0.0.0:9051 >> /etc/tor/torrc
		echo HashedControlPassword `/usr/local/bin/tor --quiet --hash-password ${ControlPassword} 2>/dev/null` >> /etc/tor/torrc
	fi

	# exit policy customization
	if [ ! -z ${ExitPolicy} ]; then
		echo ExitPolicy $ExitPolicy >> /etc/tor/torrc
	else
		echo ExitPolicy reject *:* >> /etc/tor/torrc
	fi

fi


# switch to Tor process
exec /usr/local/bin/tor -f /etc/tor/torrc
