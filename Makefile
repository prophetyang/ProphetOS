include configs/project.conf
include configs/rootfs.conf

BUILD_DIRS = firmware

.PHONY: image

all: precreate_dir build rootfs image

precreate_dir:
	for i in $(PRECREATE_DIRS); do \
		[ -d $$i ] || mkdir $$i ; \
	done

clean_precreate_dir:
	[ ! -d $(OUTPUT_DIR) ] || rm -rf $(OUTPUT_DIR)

build:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ; \
	done

rootfs:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ; \
	done

image:
	$(MAKE) -C image

clean: clean_precreate_dir
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ; \
	done

test:
	$(MAKE) -C image $@
