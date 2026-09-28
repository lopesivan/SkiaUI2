# =============================================================================
# Navegação principal
# =============================================================================
back: ## envia botão voltar
	$(KEYEVENT) KEYCODE_BACK
home: ## envia botão home
	$(KEYEVENT) KEYCODE_HOME
menu: ## envia botão menu
	$(KEYEVENT) KEYCODE_MENU
ok: ## envia botão OK (dpad center)
	$(KEYEVENT) KEYCODE_DPAD_CENTER
recents: ## abre apps recentes
	$(KEYEVENT) KEYCODE_APP_SWITCH
search: ## abre busca
	$(KEYEVENT) KEYCODE_SEARCH
assist: ## abre assistente (API 19)
	$(KEYEVENT) KEYCODE_ASSIST
voice-assist: ## assistente de voz (API 21)
	$(KEYEVENT) KEYCODE_VOICE_ASSIST
all-apps: ## todos os apps (API 28)
	$(KEYEVENT) KEYCODE_ALL_APPS
refresh: ## atualiza (API 28)
	$(KEYEVENT) KEYCODE_REFRESH
# help: ## abre ajuda (API 23)
# 	$(KEYEVENT) KEYCODE_HELP
settings: ## abre configurações
	$(KEYEVENT) KEYCODE_SETTINGS
notification: ## abre notificações
	$(KEYEVENT) KEYCODE_NOTIFICATION
profile-switch: ## troca perfil (API 29)
	$(KEYEVENT) KEYCODE_PROFILE_SWITCH

# =============================================================================
# Dpad
# =============================================================================
dpad-up: ## dpad para cima
	$(KEYEVENT) KEYCODE_DPAD_UP
dpad-down: ## dpad para baixo
	$(KEYEVENT) KEYCODE_DPAD_DOWN
dpad-left: ## dpad para esquerda
	$(KEYEVENT) KEYCODE_DPAD_LEFT
dpad-right: ## dpad para direita
	$(KEYEVENT) KEYCODE_DPAD_RIGHT
dpad-up-left: ## diagonal (API 24)
	$(KEYEVENT) KEYCODE_DPAD_UP_LEFT
dpad-up-right: ## diagonal (API 24)
	$(KEYEVENT) KEYCODE_DPAD_UP_RIGHT
dpad-down-left: ## diagonal (API 24)
	$(KEYEVENT) KEYCODE_DPAD_DOWN_LEFT
dpad-down-right: ## diagonal (API 24)
	$(KEYEVENT) KEYCODE_DPAD_DOWN_RIGHT

# =============================================================================
# Navegação do sistema (API 25)
# =============================================================================
nav-up: ## navegação sistema para cima
	$(KEYEVENT) KEYCODE_SYSTEM_NAVIGATION_UP
nav-down: ## navegação sistema para baixo
	$(KEYEVENT) KEYCODE_SYSTEM_NAVIGATION_DOWN
nav-left: ## navegação sistema para esquerda
	$(KEYEVENT) KEYCODE_SYSTEM_NAVIGATION_LEFT
nav-right: ## navegação sistema para direita
	$(KEYEVENT) KEYCODE_SYSTEM_NAVIGATION_RIGHT
navigate-prev: ## navega para anterior (API 23)
	$(KEYEVENT) KEYCODE_NAVIGATE_PREVIOUS
navigate-next: ## navega para próximo (API 23)
	$(KEYEVENT) KEYCODE_NAVIGATE_NEXT
navigate-in: ## navega para dentro (API 23)
	$(KEYEVENT) KEYCODE_NAVIGATE_IN
navigate-out: ## navega para fora (API 23)
	$(KEYEVENT) KEYCODE_NAVIGATE_OUT

# =============================================================================
# Volume e áudio
# =============================================================================
volume-up: ## aumenta volume
	$(KEYEVENT) KEYCODE_VOLUME_UP
volume-down: ## diminui volume
	$(KEYEVENT) KEYCODE_VOLUME_DOWN
volume-mute: ## muta volume (API 11)
	$(KEYEVENT) KEYCODE_VOLUME_MUTE
mute: ## muta microfone
	$(KEYEVENT) KEYCODE_MUTE
headsethook: ## headset hook (play/pause fone)
	$(KEYEVENT) KEYCODE_HEADSETHOOK

# =============================================================================
# Mídia
# =============================================================================
media-play: ## play (API 11)
	$(KEYEVENT) KEYCODE_MEDIA_PLAY
media-pause: ## pause (API 11)
	$(KEYEVENT) KEYCODE_MEDIA_PAUSE
media-play-pause: ## play/pause toggle
	$(KEYEVENT) KEYCODE_MEDIA_PLAY_PAUSE
media-stop: ## stop
	$(KEYEVENT) KEYCODE_MEDIA_STOP
media-next: ## próxima faixa
	$(KEYEVENT) KEYCODE_MEDIA_NEXT
media-prev: ## faixa anterior
	$(KEYEVENT) KEYCODE_MEDIA_PREVIOUS
media-ff: ## fast forward
	$(KEYEVENT) KEYCODE_MEDIA_FAST_FORWARD
media-rw: ## rewind
	$(KEYEVENT) KEYCODE_MEDIA_REWIND
media-record: ## gravar (API 11)
	$(KEYEVENT) KEYCODE_MEDIA_RECORD
media-eject: ## ejetar mídia (API 11)
	$(KEYEVENT) KEYCODE_MEDIA_EJECT
media-close: ## fechar mídia (API 11)
	$(KEYEVENT) KEYCODE_MEDIA_CLOSE
media-audio-track: ## troca faixa de áudio (API 19)
	$(KEYEVENT) KEYCODE_MEDIA_AUDIO_TRACK
media-top-menu: ## menu principal de mídia (API 21)
	$(KEYEVENT) KEYCODE_MEDIA_TOP_MENU
media-skip-fwd: ## pula para frente (API 24)
	$(KEYEVENT) KEYCODE_MEDIA_SKIP_FORWARD
media-skip-bwd: ## pula para trás (API 24)
	$(KEYEVENT) KEYCODE_MEDIA_SKIP_BACKWARD
media-step-fwd: ## passo para frente (API 24)
	$(KEYEVENT) KEYCODE_MEDIA_STEP_FORWARD
media-step-bwd: ## passo para trás (API 24)
	$(KEYEVENT) KEYCODE_MEDIA_STEP_BACKWARD

# =============================================================================
# Sistema
# =============================================================================
power: ## botão power
	$(KEYEVENT) KEYCODE_POWER
sleep: ## coloca em sleep (API 20)
	$(KEYEVENT) KEYCODE_SLEEP
soft-sleep: ## sleep suave sem apagar tela (API 24)
	$(KEYEVENT) KEYCODE_SOFT_SLEEP
wakeup: ## acorda o dispositivo (API 20)
	$(KEYEVENT) KEYCODE_WAKEUP
camera: ## abre câmera
	$(KEYEVENT) KEYCODE_CAMERA
camera-focus: ## foco da câmera
	$(KEYEVENT) KEYCODE_FOCUS
brightness-up: ## aumenta brilho (API 18)
	$(KEYEVENT) KEYCODE_BRIGHTNESS_UP
brightness-down: ## diminui brilho (API 18)
	$(KEYEVENT) KEYCODE_BRIGHTNESS_DOWN
pairing: ## emparelhamento Bluetooth (API 21)
	$(KEYEVENT) KEYCODE_PAIRING

# =============================================================================
# Telefone
# =============================================================================
call: ## atende chamada
	$(KEYEVENT) KEYCODE_CALL
endcall: ## encerra chamada
	$(KEYEVENT) KEYCODE_ENDCALL

# =============================================================================
# Texto / edição
# =============================================================================
enter: ## tecla enter
	$(KEYEVENT) KEYCODE_ENTER
del: ## backspace
	$(KEYEVENT) KEYCODE_DEL
forward-del: ## delete (forward) (API 11)
	$(KEYEVENT) KEYCODE_FORWARD_DEL
tab: ## tab
	$(KEYEVENT) KEYCODE_TAB
space: ## espaço
	$(KEYEVENT) KEYCODE_SPACE
escape: ## escape (API 11)
	$(KEYEVENT) KEYCODE_ESCAPE
clear: ## limpa campo
	$(KEYEVENT) KEYCODE_CLEAR
move-home: ## início da linha (API 11)
	$(KEYEVENT) KEYCODE_MOVE_HOME
move-end: ## fim da linha (API 11)
	$(KEYEVENT) KEYCODE_MOVE_END
page-up: ## page up (API 9)
	$(KEYEVENT) KEYCODE_PAGE_UP
page-down: ## page down (API 9)
	$(KEYEVENT) KEYCODE_PAGE_DOWN
insert: ## insert (API 11)
	$(KEYEVENT) KEYCODE_INSERT
caps-lock: ## caps lock (API 11)
	$(KEYEVENT) KEYCODE_CAPS_LOCK
scroll-lock: ## scroll lock (API 11)
	$(KEYEVENT) KEYCODE_SCROLL_LOCK
num-lock: ## num lock (API 11)
	$(KEYEVENT) KEYCODE_NUM_LOCK
forward: ## avançar browser (API 11)
	$(KEYEVENT) KEYCODE_FORWARD
cut: ## recortar (API 24)
	$(KEYEVENT) KEYCODE_CUT
copy: ## copiar (API 24)
	$(KEYEVENT) KEYCODE_COPY
paste: ## colar (API 24)
	$(KEYEVENT) KEYCODE_PASTE

# =============================================================================
# Modificadores
# =============================================================================
alt-left:
	$(KEYEVENT) KEYCODE_ALT_LEFT
alt-right:
	$(KEYEVENT) KEYCODE_ALT_RIGHT
shift-left:
	$(KEYEVENT) KEYCODE_SHIFT_LEFT
shift-right:
	$(KEYEVENT) KEYCODE_SHIFT_RIGHT
ctrl-left:
	$(KEYEVENT) KEYCODE_CTRL_LEFT
ctrl-right:
	$(KEYEVENT) KEYCODE_CTRL_RIGHT
meta-left:
	$(KEYEVENT) KEYCODE_META_LEFT
meta-right:
	$(KEYEVENT) KEYCODE_META_RIGHT

# =============================================================================
# Teclado numérico (API 11)
# =============================================================================
numpad-0:
	$(KEYEVENT) KEYCODE_NUMPAD_0
numpad-1:
	$(KEYEVENT) KEYCODE_NUMPAD_1
numpad-2:
	$(KEYEVENT) KEYCODE_NUMPAD_2
numpad-3:
	$(KEYEVENT) KEYCODE_NUMPAD_3
numpad-4:
	$(KEYEVENT) KEYCODE_NUMPAD_4
numpad-5:
	$(KEYEVENT) KEYCODE_NUMPAD_5
numpad-6:
	$(KEYEVENT) KEYCODE_NUMPAD_6
numpad-7:
	$(KEYEVENT) KEYCODE_NUMPAD_7
numpad-8:
	$(KEYEVENT) KEYCODE_NUMPAD_8
numpad-9:
	$(KEYEVENT) KEYCODE_NUMPAD_9
numpad-enter:
	$(KEYEVENT) KEYCODE_NUMPAD_ENTER
numpad-add:
	$(KEYEVENT) KEYCODE_NUMPAD_ADD
numpad-sub:
	$(KEYEVENT) KEYCODE_NUMPAD_SUBTRACT
numpad-mul:
	$(KEYEVENT) KEYCODE_NUMPAD_MULTIPLY
numpad-div:
	$(KEYEVENT) KEYCODE_NUMPAD_DIVIDE
numpad-dot:
	$(KEYEVENT) KEYCODE_NUMPAD_DOT

# =============================================================================
# Teclas de função (API 11)
# =============================================================================
f1:
	$(KEYEVENT) KEYCODE_F1
f2:
	$(KEYEVENT) KEYCODE_F2
f3:
	$(KEYEVENT) KEYCODE_F3
f4:
	$(KEYEVENT) KEYCODE_F4
f5:
	$(KEYEVENT) KEYCODE_F5
f6:
	$(KEYEVENT) KEYCODE_F6
f7:
	$(KEYEVENT) KEYCODE_F7
f8:
	$(KEYEVENT) KEYCODE_F8
f9:
	$(KEYEVENT) KEYCODE_F9
f10:
	$(KEYEVENT) KEYCODE_F10
f11:
	$(KEYEVENT) KEYCODE_F11
f12:
	$(KEYEVENT) KEYCODE_F12

# =============================================================================
# Apps / funções especiais
# =============================================================================
explorer:   ## abre explorador de arquivos
	$(KEYEVENT) KEYCODE_EXPLORER
envelope:   ## abre email
	$(KEYEVENT) KEYCODE_ENVELOPE
contacts:   ## abre contatos (API 15)
	$(KEYEVENT) KEYCODE_CONTACTS
calendar:   ## abre calendário (API 15)
	$(KEYEVENT) KEYCODE_CALENDAR
music:      ## abre música (API 15)
	$(KEYEVENT) KEYCODE_MUSIC
calculator: ## abre calculadora (API 15)
	$(KEYEVENT) KEYCODE_CALCULATOR
bookmark:   ## bookmark
	$(KEYEVENT) KEYCODE_BOOKMARK
thumbs-up:  ## polegar para cima (API 29)
	$(KEYEVENT) KEYCODE_THUMBS_UP
thumbs-down: ## polegar para baixo (API 29)
	$(KEYEVENT) KEYCODE_THUMBS_DOWN

# =============================================================================
# TV / mídia avançada
# =============================================================================
tv:
	$(KEYEVENT) KEYCODE_TV
tv-power:
	$(KEYEVENT) KEYCODE_TV_POWER
tv-input:
	$(KEYEVENT) KEYCODE_TV_INPUT
tv-input-hdmi-1:
	$(KEYEVENT) KEYCODE_TV_INPUT_HDMI_1
tv-input-hdmi-2:
	$(KEYEVENT) KEYCODE_TV_INPUT_HDMI_2
tv-input-hdmi-3:
	$(KEYEVENT) KEYCODE_TV_INPUT_HDMI_3
tv-input-hdmi-4:
	$(KEYEVENT) KEYCODE_TV_INPUT_HDMI_4
channel-up:
	$(KEYEVENT) KEYCODE_CHANNEL_UP
channel-down:
	$(KEYEVENT) KEYCODE_CHANNEL_DOWN
last-channel:
	$(KEYEVENT) KEYCODE_LAST_CHANNEL
info:
	$(KEYEVENT) KEYCODE_INFO
guide:
	$(KEYEVENT) KEYCODE_GUIDE
dvr:
	$(KEYEVENT) KEYCODE_DVR
captions:
	$(KEYEVENT) KEYCODE_CAPTIONS
window:
	$(KEYEVENT) KEYCODE_WINDOW
zoom-in:
	$(KEYEVENT) KEYCODE_ZOOM_IN
zoom-out:
	$(KEYEVENT) KEYCODE_ZOOM_OUT
prog-red:
	$(KEYEVENT) KEYCODE_PROG_RED
prog-green:
	$(KEYEVENT) KEYCODE_PROG_GREEN
prog-yellow:
	$(KEYEVENT) KEYCODE_PROG_YELLOW
prog-blue:
	$(KEYEVENT) KEYCODE_PROG_BLUE

# =============================================================================
# Wearables / Stem (API 24)
# =============================================================================
stem-primary:
	$(KEYEVENT) KEYCODE_STEM_PRIMARY
stem-1:
	$(KEYEVENT) KEYCODE_STEM_1
stem-2:
	$(KEYEVENT) KEYCODE_STEM_2
stem-3:
	$(KEYEVENT) KEYCODE_STEM_3

# =============================================================================
# Apps de vídeo (API 30)
# =============================================================================
video-app-1:
	$(KEYEVENT) KEYCODE_VIDEO_APP_1
video-app-2:
	$(KEYEVENT) KEYCODE_VIDEO_APP_2
video-app-3:
	$(KEYEVENT) KEYCODE_VIDEO_APP_3
video-app-4:
	$(KEYEVENT) KEYCODE_VIDEO_APP_4
video-app-5:
	$(KEYEVENT) KEYCODE_VIDEO_APP_5
video-app-6:
	$(KEYEVENT) KEYCODE_VIDEO_APP_6
video-app-7:
	$(KEYEVENT) KEYCODE_VIDEO_APP_7
video-app-8:
	$(KEYEVENT) KEYCODE_VIDEO_APP_8
featured-app-1:
	$(KEYEVENT) KEYCODE_FEATURED_APP_1
featured-app-2:
	$(KEYEVENT) KEYCODE_FEATURED_APP_2
featured-app-3:
	$(KEYEVENT) KEYCODE_FEATURED_APP_3
featured-app-4:
	$(KEYEVENT) KEYCODE_FEATURED_APP_4

# =============================================================================
# Gamepad
# =============================================================================
btn-a:
	$(KEYEVENT) KEYCODE_BUTTON_A
btn-b:
	$(KEYEVENT) KEYCODE_BUTTON_B
btn-c:
	$(KEYEVENT) KEYCODE_BUTTON_C
btn-x:
	$(KEYEVENT) KEYCODE_BUTTON_X
btn-y:
	$(KEYEVENT) KEYCODE_BUTTON_Y
btn-z:
	$(KEYEVENT) KEYCODE_BUTTON_Z
btn-l1:
	$(KEYEVENT) KEYCODE_BUTTON_L1
btn-r1:
	$(KEYEVENT) KEYCODE_BUTTON_R1
btn-l2:
	$(KEYEVENT) KEYCODE_BUTTON_L2
btn-r2:
	$(KEYEVENT) KEYCODE_BUTTON_R2
btn-thumbl:
	$(KEYEVENT) KEYCODE_BUTTON_THUMBL
btn-thumbr:
	$(KEYEVENT) KEYCODE_BUTTON_THUMBR
btn-start:
	$(KEYEVENT) KEYCODE_BUTTON_START
btn-select:
	$(KEYEVENT) KEYCODE_BUTTON_SELECT
btn-mode:
	$(KEYEVENT) KEYCODE_BUTTON_MODE
btn-1:
	$(KEYEVENT) KEYCODE_BUTTON_1
btn-2:
	$(KEYEVENT) KEYCODE_BUTTON_2
btn-3:
	$(KEYEVENT) KEYCODE_BUTTON_3
btn-4:
	$(KEYEVENT) KEYCODE_BUTTON_4
btn-5:
	$(KEYEVENT) KEYCODE_BUTTON_5
btn-6:
	$(KEYEVENT) KEYCODE_BUTTON_6
btn-7:
	$(KEYEVENT) KEYCODE_BUTTON_7
btn-8:
	$(KEYEVENT) KEYCODE_BUTTON_8
btn-9:
	$(KEYEVENT) KEYCODE_BUTTON_9
btn-10:
	$(KEYEVENT) KEYCODE_BUTTON_10
btn-11:
	$(KEYEVENT) KEYCODE_BUTTON_11
btn-12:
	$(KEYEVENT) KEYCODE_BUTTON_12
btn-13:
	$(KEYEVENT) KEYCODE_BUTTON_13
btn-14:
	$(KEYEVENT) KEYCODE_BUTTON_14
btn-15:
	$(KEYEVENT) KEYCODE_BUTTON_15
btn-16:
	$(KEYEVENT) KEYCODE_BUTTON_16

