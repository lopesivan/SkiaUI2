# -----------------------------------------------------------------------------
# ENERGIA / BOOT -- reboot, recovery, bootloader, poweroff
# -----------------------------------------------------------------------------

reboot: ## reinicia o dispositivo
	$(call log,$@)
	$(ADB) reboot

recovery: ## reinicia em modo recovery
	$(call log,$@)
	$(ADB) reboot recovery

bootloader: ## reinicia em modo bootloader/download, se suportado
	$(call log,$@)
	$(ADB) reboot bootloader

poweroff: ## desliga o dispositivo via reboot -p
	$(call log,$@)
	$(ADB_SHELL) reboot -p

shutdown: ## desliga o dispositivo via poweroff
	$(call log,$@)
	$(ADB_SHELL) poweroff
