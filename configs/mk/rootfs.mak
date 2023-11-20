build-rootfs: rootfs-pack

ROOTFS_CFLAGS := "-mcpu=cortex-m4 \
-mlittle-endian -mthumb \
-Os -ffast-math \
-ffunction-sections -fdata-sections \
-Wl,--gc-sections \
-fno-common \
--param max-inline-insns-single=1000"

busybox: generate-image
	$(shell mkdir -p ${target_out_busybox})
	$(shell mkdir -p ${target_out_romfs})
	cp -f configs/busybox_config $(target_out_busybox)/.config
	make -C $(busybox_path)/$(busybox_version) \
		O=$(target_out_busybox) oldconfig
	make -C $(target_out_busybox) \
		ARCH=arm CROSS_COMPILE=$(ROOTFS_CROSS_COMPILE) \
		CFLAGS=$(ROOTFS_CFLAGS) SKIP_STRIP=y \
		CONFIG_PREFIX=$(target_out_romfs) install

# rootfs-pack: $(romfs_dir) $(target_out_busybox)/.config
rootfs-pack: busybox
	cp -af $(romfs_dir)/* $(target_out_romfs)
# cp -f $(target_out_linux)/fs/ext2/ext2.ko $(target_out_romfs)/lib/modules
# cp -f $(target_out_linux)/fs/mbcache.ko $(target_out_romfs)/lib/modules
	cd $(target_out) && genromfs -v \
		-V "ROM Disk" \
		-f romfs.bin \
		-x placeholder \
		-d $(target_out_romfs) 2> $(target_out)/romfs.map
