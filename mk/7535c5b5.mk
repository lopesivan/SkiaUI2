# -----------------------------------------------------------------------------
# TECLADO NUMÉRICO -- tela de bloqueio (PIN)
#
# RX8N9045ELX
#
#   1 : tap 180 756      2 : tap 360 756      3 : tap 540 756
#   4 : tap 180 928      5 : tap 360 928      6 : tap 540 928
#   7 : tap 180 1100     8 : tap 360 1100     9 : tap 540 1100
#   0 : tap 360 1272
# -----------------------------------------------------------------------------

LINHA_1 := 756
LINHA_2 := 928
LINHA_3 := 1100
LINHA_4 := 1272

COLUNA_1 := 180
COLUNA_2 := 360
COLUNA_3 := 540

KEY_1_X := $(COLUNA_1)
KEY_1_Y := $(LINHA_1)
KEY_2_X := $(COLUNA_2)
KEY_2_Y := $(LINHA_1)
KEY_3_X := $(COLUNA_3)
KEY_3_Y := $(LINHA_1)

KEY_4_X := $(COLUNA_1)
KEY_4_Y := $(LINHA_2)
KEY_5_X := $(COLUNA_2)
KEY_5_Y := $(LINHA_2)
KEY_6_X := $(COLUNA_3)
KEY_6_Y := $(LINHA_2)

KEY_7_X := $(COLUNA_1)
KEY_7_Y := $(LINHA_3)
KEY_8_X := $(COLUNA_2)
KEY_8_Y := $(LINHA_3)
KEY_9_X := $(COLUNA_3)
KEY_9_Y := $(LINHA_3)

KEY_back_X := $(COLUNA_1)
KEY_back_Y := $(LINHA_4)
KEY_0_X    := $(COLUNA_2)
KEY_0_Y    := $(LINHA_4)
KEY_next_X := $(COLUNA_3)
KEY_next_Y := $(LINHA_4)

# -----------------------------------------------------------------------------
# TECLADO NUMÉRICO -- alvos
# -----------------------------------------------------------------------------

key-1: ## toca na tecla 1
	$(call log,$@)
	$(TAP) $(KEY_1_X) $(KEY_1_Y)

key-2: ## toca na tecla 2
	$(call log,$@)
	$(TAP) $(KEY_2_X) $(KEY_2_Y)

key-3: ## toca na tecla 3
	$(call log,$@)
	$(TAP) $(KEY_3_X) $(KEY_3_Y)

key-4: ## toca na tecla 4
	$(call log,$@)
	$(TAP) $(KEY_4_X) $(KEY_4_Y)

key-5: ## toca na tecla 5
	$(call log,$@)
	$(TAP) $(KEY_5_X) $(KEY_5_Y)

key-6: ## toca na tecla 6
	$(call log,$@)
	$(TAP) $(KEY_6_X) $(KEY_6_Y)

key-7: ## toca na tecla 7
	$(call log,$@)
	$(TAP) $(KEY_7_X) $(KEY_7_Y)

key-8: ## toca na tecla 8
	$(call log,$@)
	$(TAP) $(KEY_8_X) $(KEY_8_Y)

key-9: ## toca na tecla 9
	$(call log,$@)
	$(TAP) $(KEY_9_X) $(KEY_9_Y)

key-0: ## toca na tecla 0
	$(call log,$@)
	$(TAP) $(KEY_0_X) $(KEY_0_Y)

key-back: ## toca no backspace do teclado numérico
	$(call log,$@)
	$(TAP) $(KEY_back_X) $(KEY_back_Y)

key-next: ## toca em próximo/confirmar no teclado numérico
	$(call log,$@)
	$(TAP) $(KEY_next_X) $(KEY_next_Y)

# -----------------------------------------------------------------------------
# DESBLOQUEIO -- PIN 424242 + confirmação
# -----------------------------------------------------------------------------
KEY_4_BTN := $(KEY_4_X) $(KEY_4_Y)
KEY_2_BTN := $(KEY_2_X) $(KEY_2_Y)

unlock: ## digita o PIN 2244 e confirma
	$(call log,$@)
	$(TAP) $(KEY_4_BTN)
	$(TAP) $(KEY_2_BTN)
	$(TAP) $(KEY_4_BTN)
	$(TAP) $(KEY_2_BTN)
	$(TAP) $(KEY_4_BTN)
	$(TAP) $(KEY_2_BTN)
	$(KEYEVENT) KEYCODE_ENTER

swipe-up: ## desliza para cima na tela de bloqueio (desbloqueio)
	$(call log,$@)
	$(SWIPE) 540 1800 540 400 300

swipe-go-home: ## swipe de baixo para cima para ir à home
	$(call log,$@)
	$(SWIPE) 360 1382 360 200 300

open: ## liga tela, faz swipe e desbloqueia (sequência completa)
	$(call log,$@)
	$(MAKE) onoff-screen
	sleep 1
	$(MAKE) swipe-up
	sleep 1
	$(MAKE) unlock

