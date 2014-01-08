
install:
	install 80-asante-porter.rules /etc/udev/rules.d/
	udevadm control --reload-rules
