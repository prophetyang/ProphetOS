all: install_bootloader

install_bootloader:
	sudo extlinux --install $(IMAGE_DIR)/boot
	sudo cp -f extlinux.conf $(IMAGE_DIR)/boot
	sudo dd if=mbr.bin of=$(IMAGE_NAME) bs=440 count=1 conv=notrunc	
