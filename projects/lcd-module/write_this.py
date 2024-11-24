#!/usr/bin/python

#
# Testing driving an LCD connected to an MCP23008 GPIO extender.
#
# Uses the library at https://github.com/adafruit/Adafruit_Python_CharLCD.git
# which in turn uses  https://github.com/adafruit/Adafruit_Python_GPIO.git
# Note this is confusingly different from the CharLCD module in 
# https://github.com/adafruit/Adafruit-Raspberry-Pi-Python-Code.git
#
# Based directly on examples/char_lcd_mcp.py in the Adafruit_Python_CharLCD lib.
#

import sys

import Adafruit_CharLCD as LCD
import Adafruit_GPIO.MCP230xx as MCP

# Define MCP pins connected to the LCD.
lcd_rs        = 0
lcd_en        = 1
lcd_d4        = 2
lcd_d5        = 3
lcd_d6        = 4
lcd_d7        = 5
lcd_backlight = 6

# Define LCD column and row size for 16x2 LCD.
lcd_columns = 20
lcd_rows    = 4

# Initialize MCP23008 device using its default 0x20 I2C address.
gpio = MCP.MCP23008()

# Initialize the LCD using the pins 
lcd = LCD.Adafruit_CharLCD(lcd_rs, lcd_en, lcd_d4, lcd_d5, lcd_d6, lcd_d7, 
							lcd_columns, lcd_rows, lcd_backlight, gpio=gpio)

if len(sys.argv) > 1:
	lcd.clear()
	lcd.message(sys.argv[1])
else:
	lcd.set_backlight(0)

# vim: ts=4:sw=4
