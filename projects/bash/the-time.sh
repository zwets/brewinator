#!/bin/bash
# 
# the-time.sh
#
#   Taken from http://log.liminastudio.com/writing/tutorials/tutorial-how-to-use-your-raspberry-pi-like-an-arduino 

init_output_gpio() {
    echo $1 > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio$1/direction
}

init_input_gpio() {
    echo $1 > /sys/class/gpio/export
    echo in > /sys/class/gpio/gpio$1/direction
}

release_gpio() {
    echo $1 > /sys/class/gpio/unexport
}

set_high() {
    echo 1 > /sys/class/gpio/gpio$1/value
}

set_low() {
    echo 0 > /sys/class/gpio/gpio$1/value
}

get_value() {
    cat /sys/class/gpio/gpio$1/value
}

report() {
    echo -n "button value: " 
    get_value $BUTTON
}

flash () {
    COUNT=${2:-1}
    while ((COUNT)); do
        set_high $1
        sleep 0.2
        set_low $1
        sleep 0.2
        ((COUNT=COUNT-1))
    done
}

flash_the_time () {
    H1=$(date +%H | head -c 1)
    H2=$(date +%H | tail -c 2)
    M1=$(date +%M | head -c 1)
    M2=$(date +%M | tail -c 2)
    set_high $YELLOW
    flash $RED $H1
    flash $GREEN $H2
    sleep 0.5
    set_low $YELLOW
    flash $RED $M1
    flash $GREEN $M2
    sleep 1
}

BUTTON=2
GREEN=4
YELLOW=17
RED=22

(( $(id -u) )) && echo "Be root." 1>&2 && exit 

on_exit () {
    set_low $GREEN
    set_low $YELLOW
    set_low $RED

    release_gpio $BUTTON
    release_gpio $RED
    release_gpio $YELLOW
    release_gpio $GREEN
}

trap on_exit EXIT

init_output_gpio $GREEN
init_output_gpio $YELLOW
init_output_gpio $RED
init_input_gpio $BUTTON

while true; do
    if (( ! $(get_value $BUTTON) )); then
	set_high $RED; set_high $YELLOW; set_high $GREEN
        if (( $FLASH )); then FLASH=0; else FLASH=1; fi
	sleep 0.3
	set_low $RED; set_low $YELLOW; set_low $GREEN
	sleep 1
    fi
    if (( $FLASH )); then flash_the_time; else sleep 1; fi
done

# vim: sts=4 sw=4 ai si et

