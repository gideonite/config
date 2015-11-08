#!/bin/bash

function connect() {
    xrandr --output VGA1 --auto --preferred --primary --output LVDS1 --off
    setxkbmap -option ctrl:nocaps && xcape
    feh --bg-fill ~/Pictures/merging-galaxies.jpg
}

function disconnect() {
    xrandr --output VGA1 --off --output LVDS1 --preferred --primary
    setxkbmap -option ctrl:nocaps && xcape
    feh --bg-fill ~/Pictures/merging-galaxies.jpg
}

xrandr | grep 'LVDS1 connected primary' &> /dev/null && connect || disconnect
