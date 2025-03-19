#!/bin/sh
#wget -O /home/endevoor/.mozilla/firefox/0hjrc5t5.default-release/chrome/img/background.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"
settoday=1
while (("settoday"))
 do
  if ping -c 1 bing.com &> /dev/null
   then
    echo "bing reached downloading"
    if wget -O /home/zsolt/productivity/bing/wallp.png "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"  > /dev/null
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
#cp /home/zsolt/productivity/bing/wallp.png /home/zsolt/.config/BraveSoftware/Brave-Browser/Default/sanitized_background_images/sanitized_background_image-1-1.png
cp /home/zsolt/productivity/bing/wallp.png /home/zsolt/.mozilla/firefox/y693ha5j.default-release/chrome/img/background.png
#chown zsolt:zsolt /home/zsolt/.config/BraveSoftware/Brave-Browser/Default/sanitized_background_images/sanitized_background_image-1.png
#chmod 777 /home/zsolt/.config/BraveSoftware/Brave-Browser/Default/sanitized_background_images/sanitized_background_image-1.png
#cp /home/zsolt/productivity/bing/wallp.png /usr/share/plymouth/themes/spinner-mod/background-tile.png
#sed -i 's/"show_branded_background_image":true/"show_branded_background_image":false/' /home/zsolt/.config/BraveSoftware/Brave-Browser/Default/Preferences
echo Background changed
