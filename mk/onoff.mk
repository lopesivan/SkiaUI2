# -----------------------------------------------------------------------------
# TELA -- ligar, desligar, alternar
# -----------------------------------------------------------------------------
# Obtém o estado atual: 1 = tela apagada, 2 = tela acesa
define screen_state
$(shell $(ADB_SHELL) dumpsys display | grep "Display State=" | cut -d= -f2 )
endef

.PHONY: on-screen off-screen

# Liga a tela (se apagada)
on-screen:
	$(call log,$@)
	@if [ "$(screen_state)" = "OFF" ]; then \
		echo "Tela apagada -> ligando..."; \
		$(KEYEVENT) KEYCODE_POWER; \
	else \
		echo "Tela já está acesa."; \
	fi

# Apaga a tela (se acesa)
off-screen:
	$(call log,$@)
	@if [ "$(screen_state)" = "ON" ]; then \
		echo "Tela acesa -> apagando..."; \
		$(KEYEVENT) KEYCODE_POWER; \
	else \
		echo "Tela já está apagada."; \
	fi

onoff-screen: ## alterna estado da tela pelo botão power
	$(call log,$@)
	@if [ "$(screen_state)" = "ON" ]; then \
		echo "Tela acesa -> apagando..."; \
	else \
		echo "Tela apagada -> ligando..."; \
	fi
	$(KEYEVENT) KEYCODE_POWER

