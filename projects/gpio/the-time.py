#!/usr/bin/env python
# 
# the-time.py
#

import RPi.GPIO as GPIO
from time import sleep

DEBUG = 1

GPIO.setmode(GPIO.BCM)

#BUTTON=2
GREEN_LED = 4
YELLOW_LED = 17
RED_LED = 22

GPIO.setup(GREEN_LED, GPIO.OUT)
GPIO.setup(YELLOW_LED, GPIO.OUT)
GPIO.setup(RED_LED, GPIO.OUT)

while True:
    GPIO.output(GREEN_LED, True)
    sleep(1)
    GPIO.output(RED_LED, False)
    sleep(1)
    GPIO.output(YELLOW_LED, True)
    sleep(1)
    GPIO.output(GREEN_LED, False)
    sleep(1)
    GPIO.output(RED_LED, True)
    sleep(1)
    GPIO.output(YELLOW_LED, False)
    sleep(1)

# vim: sts=4 sw=4 ai si et

