#!/bin/bash

cat > /etc/udev/rules.d/10-asante-snap.rules <<EOF

SUBSYSTEM=="usb", \
  ATTR{idVendor}=="0403", ATTR{idProduct}=="7f38", SYMLINK+="ttySnapPump0"


EOF

udevadm control --reload-rules
