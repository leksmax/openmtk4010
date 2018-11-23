#!/bin/sh
/bin/cp -af /chrony.conf /etc/chrony/chrony.conf
if [ ! -e /etc/config/chrony ]; then
	/bin/cp -af /chrony.config /etc/config/chrony
fi
/bin/cp -af /chronyc-* /usr/bin/chronyc
/bin/cp -af /chronyd-* /usr/sbin/chronyd
/chronyd.init start
echo "[start.sh] ARGS is $ARGS"
NTP_PORT=`echo $ARGS | /usr/bin/awk '{print $1}'`
CMD_PORT=`echo $ARGS | /usr/bin/awk '{print $2}'`
/usr/sbin/chronyd -p $NTP_PORT -c $CMD_PORT -n -f /var/etc/chrony.conf
