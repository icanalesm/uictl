include config.mk

all:

install: all
	mkdir -p ${PREFIX}/bin
	cp -f uictl ${PREFIX}/bin
	chmod 755 ${PREFIX}/bin/uictl
	sed -e "s|USER|${USER}|g" -e "s|INSTALLDIR|${PREFIX}/bin|g" < 99-uictl.rules > /etc/udev/rules.d/99-uictl.rules
	chmod 644 /etc/udev/rules.d/99-uictl.rules

uninstall:
	rm -f ${PREFIX}/bin/uictl\
	      /etc/udev/rules.d/99-uictl.rules

.PHONY: all install uninstall
