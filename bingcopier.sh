#!/bin/sh
settoday=1
while (("settoday"))
 do
  if ping -c 1 bing.com &> /dev/null
   then
    echo "bing reached downloading"
    if wget -O ~/Pictures/wallp.png "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"  > /dev/null
     then
      settoday=0
    else
     echo "trying again later"
     sleep 60
    fi
   else
    echo "trying again later"
    sleep 60
  fi
done
#cp ~/productivity/bing/wallp.png ~/.config/BraveSoftware/Brave-Browser/Default/sanitized_background_images/sanitized_background_image-1-1.png
for DIR in ~/.mozilla/firefox/*; do
  if [ -e "$DIR/chrome/img/" ]; then
   echo $DIR
   cp ~/Pictures/wallp.png $DIR/chrome/img/background.png
  fi
done
#cp ~/Pictures/wallp.png ~/.mozilla/firefox/*/chrome/img/background.png
#chown zsolt:zsolt ~/.config/BraveSoftware/Brave-Browser/Default/sanitized_background_images/sanitized_background_image-1.png
#chmod 777 ~/.config/BraveSoftware/Brave-Browser/Default/sanitized_background_images/sanitized_background_image-1.png
#cp ~/productivity/bing/wallp.png /usr/share/plymouth/themes/spinner-mod/background-tile.png
#sed -i 's/"show_branded_background_image":true/"show_branded_background_image":false/' ~/.config/BraveSoftware/Brave-Browser/Default/Preferences
echo Background changed
