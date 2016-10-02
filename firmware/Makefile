BUILD_DIRS = busybox

all:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i ;\
	done

clean:
	for i in $(BUILD_DIRS); do \
		$(MAKE) -C $$i $@ ;\
	done
