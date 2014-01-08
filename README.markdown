
# asante pump

## udev rules

* http://www.reactivated.net/writing_udev_rules.html#basic

```
SUBSYSTEM=="usb", \
  ATTR{idVendor}=="0403", ATTR{idProduct}=="7f38", SYMLINK+="ttySnapPump0"
```
Creates a ttySnapPumpp0.



