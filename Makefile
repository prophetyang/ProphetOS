include configs/project.conf
include configs/image.conf

BUILD_DIRS = firmware

all: create_build_env build

create_build_env:
	for i in $(BUILD_ENV_DIRS); do \
		[ -d $$i ] || mkdir $$i ; \
	done

clean_build_env:
	for i in $(BUILD_ENV_DIRS); do \
		[ ! -d $$i ] || rm -rf  $$i ; \
	done

build:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i ; \
	done

rootfs:

create_image:
	scripts/create_image.sh $(OUTPUT_DIR)/output.img $(IMAGE_TOTAL_SIZE)

create_image_dirs:
	sudo mount -o loop,offset=$(IMAGE_MOUNT_OFFSET) $(OUTPUT_DIR)/output.img $(IMAGE_MOUNT_DIR)
	for i in $(IMAGE_DIRS) ; do \
		sudo mkdir $(IMAGE_MOUNT_DIR)/$$i ;\
	done
	ls -la $(IMAGE_MOUNT_DIR)

install_grub:
	sudo losetup /dev/loop1 $(OUTPUT_DIR)/output.img
	sudo grub-install --force --no-floppy --root-directory=$(IMAGE_MOUNT_DIR) /dev/loop1
	sudo losetup -d /dev/loop1

image: create_image create_image_dirs install_grub
	sudo umount $(IMAGE_MOUNT_DIR)

clean: clean_build_env
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ; \
	done
