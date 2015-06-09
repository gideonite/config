#!/bin/bash

CURR=`setxkbmap -query | awk '/layout/ {print $2}'`

if [ $CURR = "us" ]; then
    setxkbmap il && killall -s USR1 py3status
else
    setxkbmap us && killall -s USR1 py3status
fi
