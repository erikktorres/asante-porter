
install:
	install bin/asante-porter-name.sh /usr/local/bin/
	install 80-asante-porter.rules /etc/udev/rules.d/
	udevadm control --reload-rules
