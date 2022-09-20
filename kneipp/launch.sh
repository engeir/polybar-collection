#!/bin/bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar top -c $(dirname $0)/config.ini &
polybar usbc -c $(dirname $0)/config.ini &
#polybar -c ~/.config/polybar/config.ini external &

my_laptop_external_monitor=$(xrandr --query | grep 'HDMI-1')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar external -c $(dirname $0)/config.ini external &
fi

my_laptop_external_monitor=$(xrandr --query | grep 'DP-2')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar usbc -c $(dirname $0)/config.ini &
fi
