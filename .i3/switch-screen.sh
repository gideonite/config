#!/bin/bash

#OUTPUT=VGA1
OUTPUT=DP1

function connect() {
    #xrandr --output $OUTPUT --auto --preferred --primary --output LVDS1 --off
    xrandr --output $OUTPUT --auto --primary --output LVDS1 --off
    setxkbmap -option ctrl:nocaps && xcape
    feh --bg-fill ~/Pictures/merging-galaxies.jpg
}

function disconnect() {
    xrandr --output $OUTPUT --off --output LVDS1 --preferred --primary
    setxkbmap -option ctrl:nocaps && xcape
    feh --bg-fill ~/Pictures/merging-galaxies.jpg
    xinput --disable $(xinput | grep -i TouchPad | cut -f2 | awk -F'=' '{print $2}')
}

xrandr | grep 'LVDS1 connected primary' &> /dev/null && connect || disconnect
