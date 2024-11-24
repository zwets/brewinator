# Project DS18B20 (thermometers)

One-wire protocol means single data wire; multiple devices can go on one bus.

The Pi can drive these over a GPIO using module w1-gpio.  Default is GPIO #4,
pin 7 (L4).  Module parameter to change.

Interfacing is via `/sys/bus/w1/devices/28-*`.  File `w1_slave` has the
temperature in millicelcius.  Our thermometers are 28-00000{652f862,653885d,653aa55}.

The W1 devices require kernel modules w1-gpio and w1-therm to be loaded.  Also
in `boot/config.txt` the module must be declared with `dtoverlay=w1-gpio`.  See
`/boot/overlays/README` for more info.

Since stretch, the Pi comes with all settings pre-set.

## Wiring

- Black Gnd
- Red +3.3V
  And pull-up 4.7kOhm (use 2 10k parallel) to Green
- Green VCC is One-Wire data (with pull up over 4.7kOhm to 3.3V)
  GPIO pin default is #4, settable on `w1-gpio` module

**All thermometers can be parallel**

## Sample code

```bash
cd /sys/bus/w1/devices
for f in 28-*/w1_slave; do 
	cat $f | tail -1 | sed -e 's,^.*=\(..\)\(...\),\1.\2,'
done
```

## Scripts

See `../lcd-and-temp` project.

