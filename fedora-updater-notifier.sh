#!/bin/bash
pkcon -n refresh
upgradeable=$(dnf check-update | grep updates | wc -l)
notify-send -i system-software-update "$upgradeable new software updates are available."
