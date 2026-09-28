# -----------------------------------------------------------------------------
# SCRCPY -- espelhamento básico
# -----------------------------------------------------------------------------

ifdef ADB_SELECTED_DEVICE
  SCRCPY := $(SCRCPY) -s $(ADB_SELECTED_DEVICE)
endif

scrcpy: ## espelha a tela no PC
	$(call log,$@)
	$(SCRCPY)

scrcpy-hd: ## espelha em alta qualidade (1080p / 8Mbps)
	$(call log,$@)
	$(SCRCPY) --max-size=1080 --video-bit-rate=8M

scrcpy-full: ## espelha em tela cheia
	$(call log,$@)
	$(SCRCPY) --fullscreen

scrcpy-top: ## janela sempre no topo
	$(call log,$@)
	$(SCRCPY) --always-on-top

scrcpy-readonly: ## apenas visualização, sem controle de toque/teclado
	$(call log,$@)
	$(SCRCPY) --no-control

scrcpy-fps: ## mostra FPS no console
	$(call log,$@)
	$(SCRCPY) --print-fps

scrcpy-touches: ## mostra indicador visual de toques na tela
	$(call log,$@)
	$(SCRCPY) --show-touches

# -----------------------------------------------------------------------------
# SCRCPY -- áudio
# -----------------------------------------------------------------------------

scrcpy-noaudio: ## espelha sem áudio
	$(call log,$@)
	$(SCRCPY) --no-audio

scrcpy-mic: ## captura microfone em vez do áudio do sistema
	$(call log,$@)
	$(SCRCPY) --audio-source=mic

scrcpy-audio-dup: ## áudio no PC e no celular simultaneamente
	$(call log,$@)
	$(SCRCPY) --audio-source=playback --audio-dup

scrcpy-opus: ## usa codec de áudio opus
	$(call log,$@)
	$(SCRCPY) --audio-codec=opus

scrcpy-aac: ## usa codec de áudio aac
	$(call log,$@)
	$(SCRCPY) --audio-codec=aac

# -----------------------------------------------------------------------------
# SCRCPY -- câmera
# -----------------------------------------------------------------------------

scrcpy-camera: ## espelha câmera traseira
	$(call log,$@)
	$(SCRCPY) --video-source=camera --camera-facing=back

scrcpy-camera-front: ## espelha câmera frontal
	$(call log,$@)
	$(SCRCPY) --video-source=camera --camera-facing=front

scrcpy-camera-list: ## lista câmeras disponíveis no dispositivo
	$(call log,$@)
	$(SCRCPY) --list-cameras

scrcpy-camera-sizes: ## lista resoluções disponíveis por câmera
	$(call log,$@)
	$(SCRCPY) --list-camera-sizes

scrcpy-camera-hd: ## espelha câmera traseira em 1080p/60fps
	$(call log,$@)
	$(SCRCPY) --video-source=camera \
	          --camera-facing=back \
	          --camera-size=1920x1080 \
	          --camera-fps=60

scrcpy-camera-slow: ## usa câmera em modo high-speed (slow motion)
	$(call log,$@)
	$(SCRCPY) --video-source=camera \
	          --camera-facing=back \
	          --camera-high-speed

scrcpy-camera-43: ## usa câmera em aspect ratio 4:3
	$(call log,$@)
	$(SCRCPY) --video-source=camera \
	          --camera-ar=4:3

scrcpy-webcam: ## usa celular como webcam via v4l2loopback em /dev/video0
	$(call log,$@)
	$(SCRCPY) --video-source=camera \
	          --camera-facing=front \
	          --v4l2-sink=/dev/video0 \
	          --no-playback \
	          --lock-video-orientation=0

# -----------------------------------------------------------------------------
# SCRCPY -- gravação
# -----------------------------------------------------------------------------

scrcpy-record: ## grava tela em mp4 com timestamp no nome
	$(call log,$@)
	$(SCRCPY) --record=/tmp/$(ADB_SELECTED_DEVICE)-$(shell date +%Y%m%d-%H%M%S).mp4

scrcpy-record-mkv: ## grava tela em mkv com timestamp no nome
	$(call log,$@)
	$(SCRCPY) --record=/tmp/$(ADB_SELECTED_DEVICE)-$(shell date +%Y%m%d-%H%M%S).mkv

scrcpy-record-audio: ## grava somente áudio em opus com timestamp no nome
	$(call log,$@)
	$(SCRCPY) --no-video \
	          --record=/tmp/$(ADB_SELECTED_DEVICE)-$(shell date +%Y%m%d-%H%M%S).opus

scrcpy-record-camera: ## grava câmera traseira em mp4 com timestamp no nome
	$(call log,$@)
	$(SCRCPY) --video-source=camera \
	          --camera-facing=back \
	          --record=/tmp/$(ADB_SELECTED_DEVICE)-$(shell date +%Y%m%d-%H%M%S).mp4

scrcpy-timelimit: ## grava tela por 60 segundos com timestamp no nome
	$(call log,$@)
	$(SCRCPY) --record=/tmp/$(ADB_SELECTED_DEVICE)-$(shell date +%Y%m%d-%H%M%S).mp4 \
	          --time-limit=60

# -----------------------------------------------------------------------------
# SCRCPY -- teclado / mouse / gamepad
# -----------------------------------------------------------------------------

scrcpy-otg: ## modo OTG: teclado e mouse físico via USB, sem ADB
	$(call log,$@)
	$(SCRCPY) --otg

scrcpy-keyboard-uhid: ## teclado HID simulado (melhor compatibilidade)
	$(call log,$@)
	$(SCRCPY) --keyboard=uhid

scrcpy-mouse-uhid: ## mouse HID simulado
	$(call log,$@)
	$(SCRCPY) --mouse=uhid

scrcpy-gamepad: ## gamepad HID simulado
	$(call log,$@)
	$(SCRCPY) --gamepad=uhid

scrcpy-noinput: ## desativa teclado e mouse (somente visualização)
	$(call log,$@)
	$(SCRCPY) --keyboard=disabled --mouse=disabled

# -----------------------------------------------------------------------------
# SCRCPY -- janela
# -----------------------------------------------------------------------------

scrcpy-borderless: ## janela sem borda
	$(call log,$@)
	$(SCRCPY) --window-borderless

scrcpy-landscape: ## força orientação paisagem (90°)
	$(call log,$@)
	$(SCRCPY) --lock-video-orientation=90

scrcpy-portrait: ## força orientação retrato (0°)
	$(call log,$@)
	$(SCRCPY) --lock-video-orientation=0

scrcpy-small: ## abre janela pequena 400x800
	$(call log,$@)
	$(SCRCPY) --window-width=400 --window-height=800

scrcpy-screen-off: ## espelha com tela do celular desligada (stay-awake)
	$(call log,$@)
	$(SCRCPY) --turn-screen-off --stay-awake

scrcpy-list-displays: ## lista displays disponíveis no dispositivo
	$(call log,$@)
	$(SCRCPY) --list-displays

scrcpy-list-encoders: ## lista encoders de vídeo/áudio disponíveis
	$(call log,$@)
	$(SCRCPY) --list-encoders

# -----------------------------------------------------------------------------
# SCRCPY -- Wi-Fi
# -----------------------------------------------------------------------------

scrcpy-wifi: ## conecta via Wi-Fi: make scrcpy-wifi IP=192.168.x.x
	$(call log,$@)
	@test -n "$(IP)" || { echo "Uso: make scrcpy-wifi IP=192.168.x.x"; exit 1; }
	$(SCRCPY) --tcpip=$(IP):5555

scrcpy-wifi-auto: ## tenta detectar e conectar via Wi-Fi automaticamente
	$(call log,$@)
	$(SCRCPY) --tcpip

