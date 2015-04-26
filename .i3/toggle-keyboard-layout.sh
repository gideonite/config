#!/bin/bash

CURR=`setxkbmap -query | awk '/layout/ {print $2}'`

if [ $CURR = "en_US" ] || [ $CURR = "en" ]; then
    setxkbmap il
else
    setxkbmap en_US
fi
