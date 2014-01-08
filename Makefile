
install:
	install 80-asante-porter.rules /etc/udev/rules.d/
	install bin/asante-pump-namer.sh /usr/local/bin/
	udevadm control --reload-rules
