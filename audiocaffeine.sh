#!/bin/bash
if pactl list | grep RUNNING > /dev/null; then
# gnome-session-inhibit --inhibit suspend  sleep 65s
 systemd-inhibit --what=sleep --who=audiocaffeine --why="cus pa sink is open" --mode block sleep 65s
fi
 
