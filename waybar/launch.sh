#!/bin/bash

killall -9 waybar
killall -9 swaync
killall -9 hyprsunset
killall -9 blueman-applet

waybar &
swaync &
hyprsunset &
blueman-applet &
