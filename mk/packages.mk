# ----------------------------------------------------------------------------
# PACKAGES
# ----------------------------------------------------------------------------

.PHONY: show-packages
show-packages: ## lista todos os pacotes instalados
	@$(PM) list packages

.PHONY: show-packages-3rd
show-packages-3rd: ## lista pacotes de terceiros
	@$(PM) list packages -3

.PHONY: show-packages-system
show-packages-system: ## lista pacotes do sistema
	@$(PM) list packages -s
