#!/bin/sh

# The W1 (one-wire) devices require kernel modules w1-gpio and w1-therm
# as well as configuration in /boot/config.txt.  See ../ds18b20 for docs.

DEV_DIR="/sys/bus/w1/devices"
DEV_IDS="28-00000652f862 28-00000653885d 28-00000653aa55"

for D in $DEV_IDS; do
	F="$DEV_DIR/$D/w1_slave"
	[ -r "$F" ] && sed -Ene 's/.*t=(-?[[:digit:]]+)([[:digit:]]{3})$/\1.\2/p' "$F" || echo "??.???"	
done

