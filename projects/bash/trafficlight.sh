#!/bin/sh
# 
# trafficlights.sh
#
#   Taken from http://log.liminastudio.com/writing/tutorials/tutorial-how-to-use-your-raspberry-pi-like-an-arduino 

init_output_gpio() {
    sudo sh -c "echo $1 > /sys/class/gpio/export"
    sudo sh -c "echo out > /sys/class/gpio/gpio$1/direction"
}

init_input_gpio() {
    sudo sh -c "echo $1 > /sys/class/gpio/export"
    sudo sh -c "echo in > /sys/class/gpio/gpio$1/direction"
}

release_gpio() {
    sudo sh -c "echo $1 > /sys/class/gpio/unexport"
}

set_high() {
    sudo sh -c "echo 1 > /sys/class/gpio/gpio$1/value"
}

set_low() {
    sudo sh -c "echo 0 > /sys/class/gpio/gpio$1/value"
}

get_value() {
    sudo sh -c "cat /sys/class/gpio/gpio$1/value"
}

report() {
    echo -n "button value: "
    get_value $BUTTON
}

BUTTON=2
GREEN=4
YELLOW=17
RED=22

init_output_gpio $GREEN
init_output_gpio $YELLOW
init_output_gpio $RED
init_input_gpio $BUTTON

for i in 1 2 3 4 5 6 7 8 9; do
    set_high $RED
    sleep 3
    set_high $YELLOW
    sleep 1
    set_high $GREEN
    set_low $RED
    set_low $YELLOW
    sleep 3
    set_high $YELLOW
    set_low $GREEN
    sleep 2
    set_low $YELLOW
done

set_low $GREEN
set_low $YELLOW
set_low $RED

release_gpio $BUTTON
release_gpio $RED
release_gpio $YELLOW
release_gpio $GREEN

# vim: sts=4 sw=4 ai si et

