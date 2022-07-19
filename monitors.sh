#!/bin/sh
# Toggle on/off an external monitor, HDMI does not support audio over HDMI as it's pretending that it's DVI

intern="eDP-1"
extern="HDMI-1-0"

extramonitor() {  
case "$1" in
      "disconnect") xrandr --output "$extern" --off --output "$intern" --auto ;;
      "extra") xrandr --output "$extern" --mode 2560x1080 && xrandr --output "$intern" --auto --output "$extern" --right-of "$intern" ;;
      "duplicate") xrandr --output "$extern" --set audio force-dvi --mode 2560x1080 && xrandr --output "$intern" --auto --output "$extern" --same-as "$intern" --mode 1920x1080 ;;
      *) notify-send "Multi Monitor" "Unknown Operation" ;;
  esac
}

extramonitor "$1"
