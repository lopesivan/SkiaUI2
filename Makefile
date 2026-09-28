SHELL := /usr/bin/env bash
ROOT  := ./

##############################################################################
# IDENTIDADE DO APP
##############################################################################
# Deriva de 01-exemplo -> exemplo
# Override: make NAME=outro ...
#RAW_DIR  := $(notdir $(patsubst %/,%,$(dir $(realpath $(lastword $(MAKEFILE_LIST))))))
#NAME     ?= $(shell echo "$(RAW_DIR)" | sed -E 's/^[0-9]+[-._]?//' | tr 'A-Z' 'a-z')
PACKAGE  := com.temple.skiaui
ACTIVITY := .HYSkiaUIApp
ACTIVITY := .MainActivity
ACTIVITY := .HYSkiaExampleActivity
ACTIVITY := .MainActivity



APK      := app/build/outputs/apk/debug/app-debug.apk
ABI      ?= arm64-v8a
CN       := CN=Ivan Carlos da Silva Lopes, OU=Desenvolvimento, O=Ivan Lopes, L=Rio de Janeiro, ST=Rio de Janeiro, C=BR
##############################################################################
# GRADLE WRAPPER
##############################################################################
GRADLE_VERSION  := 9.7.1
GRADLEW         := ./gradlew
GRADLEW_BAT     := gradlew.bat
WRAPPER_JAR     := gradle/wrapper/gradle-wrapper.jar
WRAPPER_PROPS   := gradle/wrapper/gradle-wrapper.properties
WRAPPER_BASE    := https://raw.githubusercontent.com/gradle/gradle/v$(GRADLE_VERSION)
WRAPPER_JAR_URL := $(WRAPPER_BASE)/gradle/wrapper/gradle-wrapper.jar
GRADLEW_URL     := $(WRAPPER_BASE)/gradlew
GRADLEW_BAT_URL := $(WRAPPER_BASE)/gradlew.bat

##############################################################################
# ANDROID SDK / NDK
##############################################################################
ANDROID_SDK      := /home/ivan/Android/Sdk
NDK_VERSION      := 29.0.14206865
ANDROID_NDK_HOME := $(ANDROID_SDK)/ndk/$(NDK_VERSION)
ADB              := $(ANDROID_SDK)/platform-tools/adb

export ANDROID_HOME     ?= $(ANDROID_SDK)
export ANDROID_SDK_ROOT ?= $(ANDROID_SDK)
export ANDROID_NDK_HOME
export JAVA_HOME        ?= /home/ivan/.jenv/versions/26

##############################################################################
# DISPOSITIVO SELECIONADO
##############################################################################
ADB_SELECTED_DEVICE := RX8N9045ELX
#ADB_SELECTED_DEVICE := 7535c5b5

# Se um dispositivo foi escolhido, força o adb a usá-lo
ifdef ADB_SELECTED_DEVICE
export ANDROID_SERIAL := $(ADB_SELECTED_DEVICE)
endif

##############################################################################
# INCLUDES
##############################################################################
include $(ROOT)/mk/tools.mk

##############################################################################
# HELPERS
##############################################################################
log = @printf "\033[36m[make]\033[0m %s\n" "$(1)"

.DEFAULT_GOAL := help

##############################################################################
# INCLUDES ADICIONAIS
##############################################################################
include $(ROOT)/mk/onoff.mk
include $(ROOT)/mk/keycode.mk
include $(ROOT)/mk/energy.mk
include $(ROOT)/mk/asciinema.mk
include $(ROOT)/mk/scrcpy.mk
include $(ROOT)/mk/screen.mk
include $(ROOT)/mk/android_inter.mk

ifdef ADB_SELECTED_DEVICE
include $(ROOT)/mk/$(ADB_SELECTED_DEVICE).mk
endif

.PHONY: help init configure images build install uninstall run clean \
        stop restart log-app about version devices shell dry env

##############################################################################
# BUILD
##############################################################################
help: ## mostra esta ajuda
	@echo "Uso:"
	@grep -hE '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

init: ## prepara o Gradle Wrapper
	@command -v java >/dev/null || { echo "Erro: Java nao encontrado"; exit 1; }
	@command -v curl >/dev/null || { echo "Erro: curl nao encontrado"; exit 1; }
	@mkdir -p "$(dir $(WRAPPER_JAR))"
	@if [[ ! -f "$(WRAPPER_JAR)" ]]; then \
		echo "==> Baixando gradle-wrapper.jar ($(GRADLE_VERSION))"; \
		curl -fL "$(WRAPPER_JAR_URL)" -o "$(WRAPPER_JAR)"; \
	fi
	@if [[ ! -f "$(GRADLEW)" ]]; then \
		echo "==> Baixando gradlew"; \
		curl -fL "$(GRADLEW_URL)" -o "$(GRADLEW)"; \
	fi
	@if [[ ! -f "$(GRADLEW_BAT)" ]]; then \
		echo "==> Baixando gradlew.bat"; \
		curl -fL "$(GRADLEW_BAT_URL)" -o "$(GRADLEW_BAT)"; \
	fi
	@if [[ ! -f "$(WRAPPER_PROPS)" ]] || ! grep -q "gradle-$(GRADLE_VERSION)-bin.zip" "$(WRAPPER_PROPS)"; then \
		echo "==> (Re)criando $(WRAPPER_PROPS) para Gradle $(GRADLE_VERSION)"; \
		printf '%s\n' \
			'distributionBase=GRADLE_USER_HOME' \
			'distributionPath=wrapper/dists' \
			'networkTimeout=10000' \
			'validateDistributionUrl=true' \
			'zipStoreBase=GRADLE_USER_HOME' \
			'zipStorePath=wrapper/dists' \
			'distributionUrl=https://services.gradle.org/distributions/gradle-$(GRADLE_VERSION)-bin.zip' \
			> "$(WRAPPER_PROPS)"; \
	fi
	@chmod +x "$(GRADLEW)"
	@$(GRADLEW) --version

configure: init ## cria local.properties e valida o ambiente
	@echo "=== Ambiente ==="
	@echo "  ANDROID_HOME     = $${ANDROID_HOME:-<vazio>}"
	@echo "  ANDROID_SDK_ROOT = $${ANDROID_SDK_ROOT:-<vazio>}"
	@echo "  ANDROID_NDK_HOME = $${ANDROID_NDK_HOME:-<vazio>}"
	@echo "  ANDROID_SERIAL   = $${ANDROID_SERIAL:-<vazio>}"
	@echo "  JAVA_HOME        = $${JAVA_HOME:-<vazio>}"
	@echo
	@SDK="$${ANDROID_SDK_ROOT:-$${ANDROID_HOME:-$(ANDROID_SDK)}}"; \
	SDK="$${SDK:-$$HOME/Android/Sdk}"; \
	[[ -d "$$SDK" ]] || { echo "Erro: Android SDK nao encontrado em $$SDK"; exit 1; }; \
	[[ -f local.properties ]] || printf 'sdk.dir=%s\n' "$$SDK" > local.properties; \
	[[ -x "$$SDK/platform-tools/adb" ]] || { echo "Erro: adb nao encontrado em $$SDK/platform-tools/adb"; exit 1; }; \
	echo "==> Android SDK: $$SDK"
	@java -version 2>&1 | grep -qE '"(1[7-9]|[2-9][0-9])' \
		|| { echo "Erro: AGP exige JDK 17+"; java -version; exit 1; }
	@$(GRADLEW) tasks --quiet >/dev/null
	@echo "==> Projeto configurado"

env: ## mostra variaveis de ambiente relevantes
	$(call log,$@)
	@echo "=== Makefile ==="
	@echo "  ANDROID_SDK      = $(ANDROID_SDK)"
	@echo "  ANDROID_NDK_HOME = $(ANDROID_NDK_HOME)"
	@echo "  ADB              = $(ADB)"
	@echo "  GRADLEW          = $(GRADLEW)"
	@echo "  PACKAGE          = $(PACKAGE)"
	@echo
	@echo "=== Ambiente ==="
	@echo "  ANDROID_HOME     = $${ANDROID_HOME:-<vazio>}"
	@echo "  ANDROID_SDK_ROOT = $${ANDROID_SDK_ROOT:-<vazio>}"
	@echo "  ANDROID_NDK_HOME = $${ANDROID_NDK_HOME:-<vazio>}"
	@echo "  ANDROID_SERIAL   = $${ANDROID_SERIAL:-<vazio>}"
	@echo "  JAVA_HOME        = $${JAVA_HOME:-<vazio>}"
	@echo "  HOME             = $${HOME}"

build: ## compila o APK debug
	@$(GRADLEW) assembleDebug

ENV_FILE := env
KEYSTORE := release.keystore

ifneq (,$(wildcard $(ENV_FILE)))
include $(ENV_FILE)
export
endif

.PHONY: debug release signing keystore clean

debug: ## Compila APK Debug
	@$(GRADLEW) assembleDebug

keystore: ## Gera a keystore para assinatura do Release
	@echo "==> Gerando $(KEYSTORE)"
	@test -n "$(RELEASE_STORE_PASSWORD)" || \
		(echo "ERRO: RELEASE_STORE_PASSWORD não definida"; exit 1)
	@test -n "$(RELEASE_KEY_ALIAS)" || \
		(echo "ERRO: RELEASE_KEY_ALIAS não definida"; exit 1)
	@test -n "$(RELEASE_KEY_PASSWORD)" || \
		(echo "ERRO: RELEASE_KEY_PASSWORD não definida"; exit 1)
	@test ! -f "$(KEYSTORE)" || \
		(echo "ERRO: $(KEYSTORE) já existe"; exit 1)
	@keytool -genkeypair \
		-v \
		-keystore "$(KEYSTORE)" \
		-alias "$(RELEASE_KEY_ALIAS)" \
		-keyalg RSA \
		-keysize 2048 \
		-validity 10000 \
		-storepass "$(RELEASE_STORE_PASSWORD)" \
		-keypass "$(RELEASE_KEY_PASSWORD)" \
		-dname "$(CN)"

signing: ## Verifica a configuração de assinatura
	@test -n "$(RELEASE_STORE_PASSWORD)" || \
		(echo "ERRO: RELEASE_STORE_PASSWORD não definida"; exit 1)
	@test -n "$(RELEASE_KEY_ALIAS)" || \
		(echo "ERRO: RELEASE_KEY_ALIAS não definida"; exit 1)
	@test -n "$(RELEASE_KEY_PASSWORD)" || \
		(echo "ERRO: RELEASE_KEY_PASSWORD não definida"; exit 1)
	@test -f "$(KEYSTORE)" || \
		(echo "ERRO: $(KEYSTORE) não encontrado. Execute: make keystore"; exit 1)

	@echo "==> Assinatura configurada"

release: signing ## Compila APK Release assinado
	@$(GRADLEW) assembleRelease

install: ## instala o APK no dispositivo
	@$(GRADLEW) installDebug

uninstall: ## remove o aplicativo do dispositivo
	@$(ADB) uninstall "$(PACKAGE)" || true

run: ## instala e abre o aplicativo
	@$(ADB) shell am start -n "$(PACKAGE)/$(PACKAGE)$(ACTIVITY)"

stop: ## encerra a aplicacao
	$(call log,$@)
	@$(ADB) shell am force-stop "$(PACKAGE)"

restart: ## encerra, reinstala e inicia a aplicacao
	$(call log,$@)
	@$(MAKE) stop install run

clean: ## remove os artefatos de compilacao
	@[[ -x "$(GRADLEW)" ]] || { echo "Erro: $(GRADLEW) nao existe; rode 'make init'"; exit 1; }
	@$(GRADLEW) clean
	@$(GRADLEW) --stop
	rm app/src/main/res/drawable/moto_velocidade.webp

deploy: init configure images build install
rebuild: images build install

images:
	cwebp -q 85 art/moto_velocidade.png \
    	-o app/src/main/res/drawable/moto_velocidade.webp

##############################################################################
# LOGS
##############################################################################
log-app: ## mostra o logcat do aplicativo em execucao
	@pid="$$($(ADB) shell pidof -s "$(PACKAGE)" | tr -d '\r')"; \
	 test -n "$$pid" || { echo "aplicativo nao esta executando"; exit 1; }; \
	 $(ADB) logcat --pid="$$pid"

trace:
	$(ADB) logcat -s ICSL

##############################################################################
# DEVICE — informações e acesso básico
##############################################################################
about: ## mostra informacoes gerais do dispositivo
	$(call log,$@)
	@echo "=== Android ==="
	@$(ADB) shell getprop ro.build.version.release
	@echo "=== Device ==="
	@$(ADB) shell getprop ro.product.model
	@echo "=== Serial ==="
	@$(ADB) get-serialno
	@echo "=== Battery ==="
	@$(ADB) shell dumpsys battery | grep -E 'level|status|temperature'
	@echo "=== Uptime ==="
	@$(ADB) shell uptime
	@echo "=== IP ==="
	@$(ADB) shell ip addr show wlan0 2>/dev/null | grep 'inet ' || echo "(sem wlan0)"
	@echo "=== CPU ==="
	@$(ADB) shell cat /proc/cpuinfo | grep -E 'Hardware|processor' | tail -2
	@$(ADB) shell cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq 2>/dev/null \
		| awk '{printf "Freq: %d MHz\n", $$1/1000}' || true
	@echo "=== RAM ==="
	@$(ADB) shell cat /proc/meminfo | grep -E 'MemTotal|MemFree|MemAvailable'
	@echo "=== Screen ==="
	@$(ADB) shell wm size
	@$(ADB) shell wm density
	@echo "=== Build ==="
	@$(ADB) shell getprop ro.build.id
	@$(ADB) shell getprop ro.product.brand
	@$(ADB) shell getprop ro.product.device
	@echo "=== Processes ==="
	@$(ADB) shell ps | wc -l
	@echo "=== Storage ==="
	@$(ADB) shell 'df -h /data 2>/dev/null | tail -1 | awk "{print \"Internal : \" \$$2 \" total, \" \$$3 \" used, \" \$$4 \" free\"}"' || true
	@$(ADB) shell 'df -h /storage/emulated/0 2>/dev/null | tail -1 | awk "{print \"Emulated : \" \$$2 \" total, \" \$$3 \" used, \" \$$4 \" free\"}"' || true

version: ## mostra a versao do kernel do dispositivo
	$(call log,$@)
	@$(ADB_EXEC_OUT) cat /proc/version

devices: ## lista dispositivos conectados via ADB
	$(call log,$@)
	@$(ADB) devices

shell: ## abre shell ADB
	$(call log,$@)
	@$(ADB_SHELL)

##############################################################################
# APP — utilitários
##############################################################################
dry: ## limpa todos os dados do app (fecha o app e limpa cache/storage)
	$(call log,$@)
	@$(ADB) shell am force-stop "$(PACKAGE)"
	@$(ADB) shell pm clear "$(PACKAGE)"


test:
	unzip -l $(APK) | grep '\.so$$'
	# readelf -d ./build/intermediates/cxx/Debug/*/obj/$(ABI)/libc++_shared.so | grep NEEDED
	# readelf -d ./build/intermediates/cxx/Debug/*/obj/$(ABI)/libwidgets_yoga_gst.so | grep NEEDED
	# readelf -d ./build/intermediates/cxx/Debug/*/obj/$(ABI)/libgstreamer_android.so | grep NEEDED
