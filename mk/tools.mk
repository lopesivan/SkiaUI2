# -----------------------------------------------------------------------------
# FERRAMENTAS BASE
# -----------------------------------------------------------------------------

ifdef ADB_SELECTED_DEVICE
  ADB := $(ADB) -s $(ADB_SELECTED_DEVICE)
endif

ADB_SHELL     := $(ADB) shell

ADB_INSTALL   := $(ADB) install
ADB_UNINSTALL := $(ADB) uninstall
ADB_PUSH      := $(ADB) push
ADB_PULL      := $(ADB) pull
ADB_EXEC_OUT  := $(ADB) exec-out

INPUT         := $(ADB_SHELL) input
SETTINGS      := $(ADB_SHELL) settings
UIAUTOMATOR   := $(ADB_SHELL) uiautomator

AM            := $(ADB_SHELL) am
PM            := $(ADB_SHELL) pm
START         := $(AM) start

TAP           := $(INPUT) tap
KEYEVENT      := $(INPUT) keyevent
SWIPE         := $(INPUT) swipe
TEXT          := $(INPUT) text
SCRCPY        := scrcpy
FFMPEG        := ffmpeg

CHROOT_DIR    := /data/local/mnt
CHROOT_SHELL  := /bin/ash
CHROOT_PATH   := /bin:/sbin:/usr/bin:/usr/sbin
CHROOT_ENV    := export PATH=$(CHROOT_PATH):\$$PATH; cd

ADB_CHROOT     = $(ADB_SHELL) -t 'su -c "chroot $(CHROOT_DIR) $(CHROOT_SHELL) -c \"$(CHROOT_ENV); $(1)\""'


