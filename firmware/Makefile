include configs/device.conf
BUILD_DIRS = busybox

all:

build:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i ;\
	done

rootfs_create_device_node:
	for i in $(DEVICE_DIRS); do \
		mkdir -p $(ROOTFS_DIR)/dev/$$i ;\
	done
	for i in $(DEVICE_NODES); do \
		echo $$i | awk -v devdir="$(ROOTFS_DIR)/dev" -F',' '{system("sudo mknod "devdir"/"$$1" "$$2" "$$3" "$$4)}' ;\
	done
	for i in $(DEVICE_LINKS); do \
		echo $$i | awk -v devdir="$(ROOTFS_DIR)/dev" -F',' '{system("ln -s "$$2" "devdir"/"$$1)}' ;\
	done

rootfs_install:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ;\
	done

rootfs: rootfs_create_device_node rootfs_install

clean:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ;\
	done
