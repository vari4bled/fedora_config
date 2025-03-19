#!/bin/bash
while true
do
 if $(pactl list | grep RUNNING > /dev/null) ; then
  #systemd-inhibit --what=sleep --who=audiocaffeine --why="cuz pa sink is open" --mode block /bin/bash ~/productivity/scripts/audiocaffeinev2loop.sh
  gnome-session-inhibit --inhibit suspend --reason "pa sink is open" /bin/bash ~/productivity/scripts/audiocaffeinev2loop.sh
 fi 
 sleep 10s
done
 
