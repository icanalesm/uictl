include config.mk

all:

install: all
	mkdir -p ${PREFIX}/bin
	cp -f uictl ${PREFIX}/bin
	chmod 755 ${PREFIX}/bin/uictl
	cp -f uictl_run ${PREFIX}/bin
	chmod 755 ${PREFIX}/bin/uictl_run
	sed -e "s|INSTALLDIR|${PREFIX}/bin|g" < 99-uictl.rules > /etc/udev/rules.d/99-uictl.rules
	chmod 644 /etc/udev/rules.d/99-uictl.rules

uninstall:
	rm -f ${PREFIX}/bin/uictl\
	      ${PREFIX}/bin/uictl_run\
	      /etc/udev/rules.d/99-uictl.rules

.PHONY: all install uninstall
