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
import math
import time

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
# Alternatively you can initialize the MCP device on another I2C address or bus.
# gpio = MCP.MCP23008(0x24, busnum=1)

# Initialize the LCD using the pins 
lcd = LCD.Adafruit_CharLCD(lcd_rs, lcd_en, lcd_d4, lcd_d5, lcd_d6, lcd_d7, 
							lcd_columns, lcd_rows, lcd_backlight, gpio=gpio)

# Print a two line message
lcd.message('Hello\nworld!')

# Wait 5 seconds
time.sleep(5.0)

# Demo showing the cursor.
lcd.clear()
lcd.show_cursor(True)
lcd.message('Show cursor')

time.sleep(5.0)

# Demo showing the blinking cursor.
lcd.clear()
lcd.blink(True)
lcd.message('Blink cursor')

time.sleep(5.0)

# Stop blinking and showing cursor.
lcd.show_cursor(False)
lcd.blink(False)

# Demo scrolling message right/left.
lcd.clear()
message = 'Scroll'
lcd.message(message)
for i in range(lcd_columns-len(message)):
	time.sleep(0.5)
	lcd.move_right()
for i in range(lcd_columns-len(message)):
	time.sleep(0.5)
	lcd.move_left()

# Demo turning backlight off and on.
lcd.clear()
lcd.message('Flash backlight\nin 5 seconds...')
time.sleep(5.0)
# Turn backlight off.
lcd.set_backlight(0)
time.sleep(2.0)
# Change message.
lcd.clear()
lcd.message('Goodbye!')
# Turn backlight on.
lcd.set_backlight(1)

# vim: ts=4:sw=4
