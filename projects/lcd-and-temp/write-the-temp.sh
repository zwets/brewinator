#!/bin/sh

# The W1 (one-wire) devices require kernel modules w1-gpio and w1-therm
# as well as configuration in /boot/config.txt.  See ../ds18b20 for docs.


DEVICE_DIR="/sys/bus/w1/devices"
WRITE_THIS="$(dirname "$0")/../lcd-module/write_this.py"
#WRITE_THIS=echo 

trap "$WRITE_THIS; exit" INT
trap "$WRITE_THIS" EXIT

while true; do 
	$WRITE_THIS "$(date +%Y-%m-%d\ \ %H:%M:%S)
$(for f in $DEVICE_DIR/28-*/w1_slave; do 
	cat $f | tail -1 | sed -e 's,^.*=\(..\)\(...\).*,\1.\2,'
done)"
	#sleep 0.5
done

