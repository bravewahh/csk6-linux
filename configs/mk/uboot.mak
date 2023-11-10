build-uboot:
	$(shell mkdir -p ${target_out_uboot})
	$(info "Build u-boot...")
	make -C $(uboot_path) \
		ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) \
		O=$(target_out_uboot) \
		stm32f429-discovery_defconfig
	make -C $(uboot_path) \
		ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) \
		O=$(target_out_uboot)