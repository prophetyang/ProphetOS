ifndef BOOTLOADER
$(error Invalid bootloader.)
endif
ifndef IMAGE_NAME 
$(error Invalid image name.)
endif

.PHONY: $(BOOTLOADER)

all: bootloader

extlinux:
	$(MAKE) -C $@

bootloader: $(BOOTLOADER)
