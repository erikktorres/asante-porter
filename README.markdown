
# asante porter

Connects FTDI usb cable to the controller module's UART.

## udev rules

* http://www.reactivated.net/writing_udev_rules.html#basic
* https://wiki.archlinux.org/index.php/udev
* `# udevadm monitor --environment --udev --kernel` - Prints items that can be
  matched using `ENV{NAME}=="..."` syntax
* `sudo modprobe ftdi_sio vendor=0x0403 product=0x7f38` - magic incantation to create a `ttyUSB0` device
* `udevadm info --attribute-walk --name /dev/ttyUSB0` - prints items that can
  be included in rules.
* `udevadm info --attribute-walk --path /devices/pci0000:00/0000:00:11.0/0000:02:00.0/usb2/2-2/2-2.2` - prints items that can
  be included in rules.
* but udev runs one entry at a time, rules cannot match across
  entries, except by passing messages via environment variables?
* Testing indicates that certain environment variables persist across
  more consistently than the device attributes.  Simplest solution is
  to always test for environment variables along with the `SUBSYSTEM`
  and perhaps `KERNEL`.

**udev rules**
```bash
# udev detects an ftdi device, (usable with libfdti I suppose)
# inserting  ftdio_sio module with our vendor's parameters creates a ttyUSB0
# udev can only match one entry at a time, but this triggers additional add entries.
ACTION=="add", SUBSYSTEM=="usb",                  \
  ATTR{idVendor}=="0403", ATTR{idProduct}=="7f38", \
  RUN+="/sbin/modprobe ftdi_sio vendor=0x0403 product=0x7f38"

# create a symlink to the ttyUSB device created automatically above
# rename to AsantePorterX where X is each connected cable/cradle starting at
# zero.
ACTION=="add",                                       \
  ENV{DEVNAME}=="ttyUSB[0-9]",                        \
  ENV{ID_MODEL_ID}=="7f38",                            \
  ENV{ID_VENDOR_ID}=="0403",                            \
  PROGRAM+="/usr/local/bin/asante-porter-name.sh %k %n", \
  SYMLINK+="%c"

# clean up, ftdi_sio can only be used once at a time
# this allows other applications to re-use ftdi_sio
ACTION=="remove",         \
  SUBSYSTEM=="usb",        \
  ENV{ID_MODEL_ID}=="7f38", \
  ENV{ID_VENDOR_ID}=="0403", \
  RUN+="/sbin/modprobe -r ftdi_sio"

```
Creates a `/dev/ttyUSB.AsantePorter0` device when one cradle is plugged in.

When the controller is connected to the cradle, the beacon starts at `9600` baud:

```bash
$ npm install
bewest@paragon:~/src/ftdi-snap$ node index.js 
Howdy let's talk to an insulin pump!
opened {}
beacon? 4 <Buffer 7e 05 00 00>
beacon? 2 <Buffer 1f 8f>
beacon? 3 <Buffer 7e 05 00>
beacon? 1 <Buffer 00>
beacon? 1 <Buffer 1f>
beacon? 1 <Buffer 8f>
beacon? 2 <Buffer 7e 05>
beacon? 1 <Buffer 00>
beacon? 1 <Buffer 00>
beacon? 2 <Buffer 1f 8f>
beacon? 1 <Buffer 7e>
beacon? 1 <Buffer 05>
beacon? 1 <Buffer 00>
beacon? 1 <Buffer 00>
beacon? 1 <Buffer 1f>
beacon? 1 <Buffer 8f>
^Cbewest@paragon:~/src/ftdi-snap$ 

```

Do the **beacon** dance.

