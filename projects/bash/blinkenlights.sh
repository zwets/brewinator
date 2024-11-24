#!/bin/bash
#
# blinkenlights.sh
# Marco van Zwetselaar <zwets@zwets.com>
# 2015-01-08 
#
# Make the built-in ACT LED on the Raspberry PI board flash 5 times,
# using just a bash script and the /sys/class interface.
#
# Based on http://elinux.org/RPi_Tutorials#Blinking_the_ACT_LED_with_a_bash_script

PREV_TRIGGER=$(sed -e 's/.*\[//' -e 's/].*//' /sys/class/leds/led0/trigger)

echo none > /sys/class/leds/led0/trigger

for (( i=1; i <= 5; i++ ))
do
  echo 1 > /sys/class/leds/led0/brightness
  sleep 1s
  echo 0 > /sys/class/leds/led0/brightness
  sleep 1s
done

echo $PREV_TRIGGER > /sys/class/leds/led0/trigger

