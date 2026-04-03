.PHONY: setup run clean

setup:
	@echo "=== Setup Folding@home ==="
	sh setup_fah.sh

run:
	@echo "=== Ejecutando Folding@home ==="
	$(eval UUID := $(shell cat /proc/sys/kernel/random/uuid | tr -d '-' | head -c 8))
	fah/usr/bin/fah-client --user=worker --team=1067987 --account-token=E-qC3E-qZgQvAZgeQhxp-QhmGIGNGGIDtDKLztDDt4E --machine-name=synergia-worker-$(UUID) --cpus=$(nproc) &
	sleep 10
	echo '{"cmd":"unpause"}' | ./websocat ws://127.0.0.1:7396/api/websocket
	echo '{"cmd":"finish"}' | ./websocat ws://127.0.0.1:7396/api/websocket
	./control_upload.sh

clean:
	rm -f gpus.json log.txt
	rm -rf cores work
