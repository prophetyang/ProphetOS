include configs/project.conf
include configs/rootfs.conf
include configs/image.conf

BUILD_DIRS = firmware

all: precreate_dir build

precreate_dir:
	for i in $(PRECREATE_DIRS); do \
		[ -d $$i ] || mkdir $$i ; \
	done

clean_precreate_dir:
	[ ! -d $(OUTPUT_DIR) ] || rm -rf $(OUTPUT_DIR)

build:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i ; \
	done

create_image:
	scripts/create_image.sh $(OUTPUT_DIR)/output.img $(IMAGE_TOTAL_SIZE)

create_image_dirs:
	sudo mount -o loop,offset=$(IMAGE_MOUNT_OFFSET) $(OUTPUT_DIR)/output.img $(IMAGE_DIR)
	for i in $(IMAGE_PRECREATE_DIRS) ; do \
		sudo mkdir $(IMAGE_DIR)/$$i ;\
	done
	ls -la $(IMAGE_DIR)

install_grub:
	sudo losetup /dev/loop1 $(OUTPUT_DIR)/output.img
	sudo grub-install --force --no-floppy --root-directory=$(IMAGE_DIR) /dev/loop1
	sudo losetup -d /dev/loop1

image: create_image create_image_dirs install_grub
	sudo umount $(IMAGE_DIR)

clean: clean_precreate_dir
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ; \
	done

