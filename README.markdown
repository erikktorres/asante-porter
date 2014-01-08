
# asante pump

## udev rules

* http://www.reactivated.net/writing_udev_rules.html#basic

```
ACTION=="add", SUBSYSTEM=="usb", \
  ATTR{idVendor}=="0403", ATTR{idProduct}=="7f38", \
  RUN+="/sbin/modprobe ftdi_sio vendor=0x0403 product=0x7f38"

KERNEL=="ttyUSB*", ACTION=="add", SUBSYSTEM=="tty"
  ENV{DEVNAME}=="ttyUSB[0-9]", \
  ENV{ID_MODEL_ID}=="7f38", \
  ENV{ID_VENDOR_ID}=="0403", \
  SYMLINK+="ttyUSB.AsantePorter%n"

ACTION=="remove", SUBSYSTEM=="usb", \
  ENV{ID_MODEL_ID}=="7f38", \
  ENV{ID_VENDOR_ID}=="0403", \
  RUN+="/sbin/modprobe -r ftdi_sio"

```
Creates a `/dev/ttyUSB.AsantePorter0` device when one cradle is plugged in.

When the controller is connected to the cradle, the beacon starts at `9600` baud:

```bash
npm install serialport
bewest@paragon:~/src/ftdi-snap$ node index.js 
Howdy let's talk to an insulin pump!
opened {}
beacon? 1 <Buffer 00>
beacon? 3 <Buffer 7e 05 00>
beacon? 1 <Buffer 00>
beacon? 2 <Buffer 1f 8f>
beacon? 2 <Buffer 7e 05>
beacon? 2 <Buffer 00 00>
beacon? 2 <Buffer 1f 8f>
beacon? 3 <Buffer 7e 05 00>
beacon? 2 <Buffer 00 1f>
beacon? 1 <Buffer 8f>
beacon? 4 <Buffer 7e 05 00 00>
beacon? 2 <Buffer 1f 8f>
^Cbewest@paragon:~/src/ftdi-snap$ 

```

Do the **beacon** dance.

