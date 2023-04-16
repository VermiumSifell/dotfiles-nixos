#!/bin/env bash

notify-send -a polybar -u low "Polybar" "Terminating instances"
#Killing instances"
#Terminating bar instances"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null
do
    sleep 1
done

## The name of the bar you want to manage
BAR_NAMES="panel"
TRAY_OUTPUT=$(xrandr | awk '/ primary / {print $1}')

## Find active monitors
ACTIVE_MONITORS=$(xrandr | awk '/ connected/{print $1}')

## For each bar, do the following
for bar in $BAR_NAMES; do

    for monitor in $ACTIVE_MONITORS; do

        if [[ "$monitor" == "$TRAY_OUTPUT" ]]; then
            POLYBAR_TRAY_POS="right" MONITOR=$monitor polybar --reload $bar >> /tmp/polybar.log 2>&1 &
        else
            POLYBAR_TRAY_POS="none" MONITOR=$monitor polybar --reload $bar >> /tmp/polybar.log 2>&1 &
        fi
            notify-send -a polybar -u low "Polybar" "Launched <b>$bar</b> for <b>$monitor</b>"

    done

done

echo "Bars launched..."
