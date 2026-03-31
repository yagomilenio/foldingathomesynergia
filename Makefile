START ?= 0
END   ?= 1

.PHONY: setup run clean

setup:
	@echo "=== Setup Folding@home ==="
	sh setup_fah.sh

run:
	@echo "=== Ejecutando Folding@home ==="
	/usr/bin/fah-client --config /var/lib/fah-client/config.xml

