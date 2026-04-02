.PHONY: setup run clean

setup:
	@echo "=== Setup Folding@home ==="
	sh setup_fah.sh

run:
	@echo "=== Ejecutando Folding@home ==="
	$(eval UUID := $(shell cat /proc/sys/kernel/random/uuid | tr -d '-' | head -c 8))
	/repo/fah-client-bastet/fah-client --user=worker --team=1067987 --account-token=qwC5gqwCFBHyOFBIY1ePFY1etH_1RtH_XHkdpXHksN0 --machine-name=synergia-worker-$(UUID) &
	sleep 10
	echo '{"cmd":"unpause"}' | ./websocat ws://127.0.0.1:7396/api/websocket
	./control_output.sh

clean:
	rm -f gpus.json log.txt
	rm -rf cores work
