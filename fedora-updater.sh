#!/bin/bash
pkcon -n update --only-download
pkcon offline-trigger
prepared=$(pkcon offline-get-prepared | grep -v "Prepared\|Command failed" | wc -l)
notify-send -i system-software-update "$prepared packages are ready to be installed."
