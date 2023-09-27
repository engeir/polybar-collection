#!/bin/bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar
pkill -f 'hideIt.sh'

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar top -c $(dirname $0)/config.ini & disown
# sleep 0.5
# hideIt.sh -w -i 0.2 -d "top" --name "polybar-top_eDP-1" --region 0x360+1920+22 & disown
# sleep 0.5
# polybar usbc -c $(dirname $0)/config.ini & disown
# polybar -c ~/.config/polybar/config.ini external & disown

my_laptop_external_monitor=$(xrandr --query | grep 'HDMI-1')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar external -c $(dirname $0)/config.ini external & disown
fi

my_laptop_external_monitor=$(xrandr --query | grep 'DP-2')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar usbc -c $(dirname $0)/config.ini & disown
    bspc config -m DP-2 top_padding 2
    sleep 0.5
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-usbc_DP-2" --region 1920x0+2560+3 & disown
fi

xdo raise -N Polybar
