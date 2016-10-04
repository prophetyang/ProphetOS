include configs/image.conf
include configs/bootloader.conf

all: image

create_dummy_image:
	[ -d $(IMAGE_DIR) ] || mkdir $(IMAGE_DIR) 
	scripts/create_image.sh $(IMAGE_NAME) $(IMAGE_TOTAL_SIZE)

create_image_dirs:
	sudo mount -o loop,offset=$(IMAGE_MOUNT_OFFSET) $(IMAGE_NAME) $(IMAGE_DIR)
	for i in $(IMAGE_PRECREATE_DIRS); do \
		sudo mkdir $(IMAGE_DIR)/$$i ;\
	done

install_image_package:

bootloader:
	make -C boot $@

image: create_dummy_image create_image_dirs install_image_package bootloader
	sudo umount $(IMAGE_DIR)

clean:
	[ ! -d $(IMAGE_DIR) ] || rm -rf $(IMAGE_DIR)

test: $(IMAGE_NAME)
	qemu-system-x86_64 -m 1024 -hda $(IMAGE_NAME) -boot c
