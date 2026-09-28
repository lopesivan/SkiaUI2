# -----------------------------------------------------------------------------
# COORDENADAS -- teclado numérico da tela de bloqueio
#
# Resolução: 720x1600 (Samsung Galaxy A21s)
# Layout:
#   [1][2][3]   y=750
#   [4][5][6]   y=900
#   [7][8][9]   y=1050
#   [<][0][>]   y=1200
#
#   colunas: 180  360  540
# -----------------------------------------------------------------------------

LINHA_1 := 750
LINHA_2 := 900
LINHA_3 := 1050
LINHA_4 := 1200

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
# COORDENADAS -- dock inferior
#
# y fixo em 1459 para todos os 5 slots do dock
# slots distribuídos horizontalmente em 84, 222, 360, 498, 636
# -----------------------------------------------------------------------------

LINHA_APP_Y := 1459

KEY_app1_X := 84
KEY_app1_Y := $(LINHA_APP_Y)
KEY_app2_X := 222
KEY_app2_Y := $(LINHA_APP_Y)
KEY_app3_X := 360
KEY_app3_Y := $(LINHA_APP_Y)
KEY_app4_X := 498
KEY_app4_Y := $(LINHA_APP_Y)
KEY_app5_X := 636
KEY_app5_Y := $(LINHA_APP_Y)

