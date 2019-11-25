#!/bin/bash

sudo=/usr/bin/sudo
openconnect=/usr/local/sbin/openconnect
iptables=/sbin/iptables	
pkill=/usr/bin/pkill

function connect {
echo "Conectando a VPN..."
$sudo $openconnect --protocol=gp ${VPNSITE} --no-dtls -b

sleep 5
echo "Aplicando Regras Iptables..."
$sudo $iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
$sudo $iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 9090 -j DNAT --to 10.104.37.160:9090
$sudo $iptables -A FORWARD -i eth0 -j ACCEPT
echo "Conectado"

/bin/bash
}

function disconnect {
	echo "Disconnecting..."
	$sudo $pkill -SIGINT openconnect

/bin/bash
}

subcommand=$1

subcommand=$1
case $subcommand in
	"-c" | "--connect")
	shift
	connect $@
	;;
	"-d" | "--disconnect")
	disconnect
	;;
	*)
	echo "Error: '$subcommand' is not a known command." >&2
	echo "Run '$prog_name --help' for a list of known commands." >&2
    /bin/bash
	exit 1
	;;
esac
