TARBALL = busybox-1.25.0.tar.bz2
BUSYBOX_DIR = $(TARBALL:.tar.bz2=)
INSTALL_DIR = $(ROOTFS_DIR)

all: build

extract: $(TARBALL)
	tar xjf $^	

config: extract $(BUSYBOX_DIR)
	cp -f configs/x86_64.config $(BUSYBOX_DIR)/.config

build: config
	$(MAKE) -C $(BUSYBOX_DIR) -j$(MAKE_JOBS)

rootfs_install:
	$(MAKE) -C $(BUSYBOX_DIR) CONFIG_PREFIX=$(INSTALL_DIR) install

clean:
	[ ! -d $(BUSYBOX_DIR) ] || rm -rf $(BUSYBOX_DIR)
