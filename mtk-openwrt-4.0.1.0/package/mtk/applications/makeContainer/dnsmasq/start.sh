#!/bin/sh
/bin/cp /dnsmasq-* /usr/sbin/dnsmasq
/dnsmasq.init start
echo "[start.sh] ARGS is $ARGS"
DNS_PORT=`echo $ARGS | /usr/bin/awk '{print $1}'`
DHCP_PORT=`echo $ARGS | /usr/bin/awk '{print $2}'`
/usr/sbin/dnsmasq --port=$DNS_PORT --dhcp-alternate-port=$DHCP_PORT,68 -C /var/etc/dnsmasq.conf.* -k -x /var/run/dnsmasq/dnsmasq.cfg02411c.pid
