#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "ERROR: Please run as root"
  exit
fi

pushd /home/pi/klipper
service klipper stop
su -c "./scripts/flash-sdcard.sh /dev/btt-skr-13 generic-lpc1768" pi
if [ $? -eq 0 ]; then
    echo "Flashing successful!"
else
    echo "Flashing failed :("
    service klipper start
    popd
    # Reset ownership
    chown pi:pi -R /home/pi/klipper
    exit 1
fi
# Reset ownership
chown pi:pi -R /home/pi/klipper
service klipper start
popd