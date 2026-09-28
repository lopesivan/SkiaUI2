ifndef MSG
    MSG := nome do usuário.
endif

text:
	$(call log,$@)
	$(TEXT) "$(MSG)"

tap:
	$(call log,$@)
	@$(UIAUTOMATOR) dump /sdcard/ui.xml
	@$(ADB_PULL) /sdcard/ui.xml /tmp/ui.xml >/dev/null 2>&1
	@python3 ui-info.py > ui.log
	@./processa-taps.sh  < ui.log| ./tap-select.py

rolagem-down:
	$(call log,$@)
	@$(ADB_SHELL) input swipe 640 700 640 200
rolagem-up:
	$(call log,$@)
	@$(ADB_SHELL) input swipe 640 200 640 700

send-text: ## envia texto para o Android e aperta ENTER. Uso: make send-text SEND_TEXT="uma mensagem"
	$(call log,$@)
	@test -n "$(SEND_TEXT)" || { echo 'uso: make send-text SEND_TEXT="uma mensagem"'; exit 1; }
	@for word in $(SEND_TEXT); do \
		$(TEXT) "$$word"; \
		$(KEYEVENT) KEYCODE_SPACE; \
	done
	@$(KEYEVENT) KEYCODE_BACKSPACE
	@$(KEYEVENT) KEYCODE_ENTER

send-text-line: ## envia texto para o Android . Uso: make send-text-line SEND_TEXT="uma mensagem"
	$(call log,$@)
	@test -n "$(SEND_TEXT)" || { echo 'uso: make send-text SEND_TEXT="uma mensagem"'; exit 1; }
	@for word in $(SEND_TEXT); do \
		$(TEXT) "$$word"; \
		$(KEYEVENT) KEYCODE_SPACE; \
	done
	$(KEYEVENT) KEYCODE_DEL

user:
	make send-text-line SEND_TEXT="admin"
pass:
	make send-text-line SEND_TEXT="1234"

matriz: run
	sleep .5
	adb shell input tap 534 1520
	sleep .5
	make ok

