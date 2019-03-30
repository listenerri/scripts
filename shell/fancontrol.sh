#!/bin/bash

PWMFILE=$(find -L /sys/class/hwmon -maxdepth 2 -name pwm1 2> /dev/null)

[[ -z $PWMFILE ]] && echo "Can not find fan speed control file" && exit -1

echo ""
echo "Using fan speed control file: $PWMFILE"
echo "The current fan speed is: $(cat "$PWMFILE")"
echo ""

read -p "Input speed(0-255) you want to set and press ENTER: " SPEED
[[ -z $SPEED ]] && SPEED=85
echo $SPEED | sudo tee "$PWMFILE"
