#!/bin/bash

cat > /etc/udev/rules.d/10-asante-snap.rules <<EOF

ACTION=="add", SUBSYSTEM=="usb", \
  ATTR{idVendor}=="0403", ATTR{idProduct}=="7f38", \
  PROGRAM="/usr/local/bin/asante-pump-namer.sh %k %n", \
  SYMLINK+="%c"

EOF

udevadm control --reload-rules
