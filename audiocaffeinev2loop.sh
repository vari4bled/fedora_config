#!/bin/bash
while $(pactl list | grep RUNNING > /dev/null)
do
  # gnome-session-inhibit --inhibit suspend  sleep 65s
  sleep 30s
done
sleep 5s
