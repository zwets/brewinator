#!/usr/bin/python

from Adafruit_MCP230xx import Adafruit_MCP230XX
import smbus
import time

if __name__ == '__main__':

    mcp = Adafruit_MCP230XX(address = 0x20, num_gpios = 8) # MCP23008
    # mcp = Adafruit_MCP230XX(address = 0x20, num_gpios = 16) # MCP23017

    # Set pins GPIO 0, 1 and 2 to output (you can set pins 0..15 this way)
    # Note pin 0 is pin 10 (right bottom) on the MCP23008, and 21 (mid-right) on MCP23017
    mcp.config(0, mcp.OUTPUT)
    mcp.config(1, mcp.OUTPUT)
    mcp.config(2, mcp.OUTPUT)

    # Set pin GPIO 3 to input with the pullup resistor enabled
    mcp.config(3, mcp.INPUT)
    mcp.pullup(3, 1)

    # Read input pin and display the results
    print "Pin 3 = %d" % (mcp.input(3) >> 3)

    # Python speed test on output 0 toggling at max speed
    print "Starting blinky on pin 0 (CTRL+C to quit)"
    while (True):
      print "Pin 3 = %d" % (mcp.input(3) >> 3)
      mcp.output(0, 1)  # Pin 0 High
      time.sleep(1);
      mcp.output(1, 1)  # Pin 1 High
      time.sleep(1);
      mcp.output(0, 0)  # Pin 0 Low
      time.sleep(1);
      mcp.output(1, 0)  # Pin 1 Low
      time.sleep(1);

