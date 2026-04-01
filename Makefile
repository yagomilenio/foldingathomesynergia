.PHONY: setup run clean

setup:
	@echo "=== Setup Folding@home ==="
	sh setup_fah.sh

run:
	@echo "=== Ejecutando Folding@home ==="
	/repo/fah-client-bastet/fah-client --user=worker --team=1067987 --account-token=qwC5gqwCFBHyOFBIY1ePFY1etH_1RtH_XHkdpXHksN0 &
	sleep 10
	echo '{"cmd":"unpause"}' | sh ./websocat ws://127.0.0.1:7396/api/websocket
	sh control_output.sh

clean:
	rm -r client.db cores gpus.json log.txt work
