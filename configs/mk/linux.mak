
empty_file_hex := "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\
				   \xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\
				   \xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\
				   \xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF"

build-linux-kernel:
	$(shell mkdir -p ${target_out_linux})
	@echo "Build linux kernel..."
	make -C $(linux_path) ARCH=arm O=$(target_out_linux) stm32_defconfig
	make -j 46 -C $(linux_path) ARCH=arm O=$(target_out_linux) CROSS_COMPILE=$(CROSS_COMPILE) dtbs xipImage

build-linux: build-linux-kernel
	$(info "pack uImage...")
	$(shell printf $(empty_file_hex) | tr -d ' ' > $(target_out_linux)/arch/arm/boot/empty_boot_header.bin)
	$(shell cat $(target_out_linux)/arch/arm/boot/empty_boot_header.bin $(target_out_linux)/arch/arm/boot/xipImage > $(target_out_linux)/arch/arm/boot/xipuimage)
	$(info $(shell mkimage -x -A arm -O linux -T kernel -C none -a 0x08040040 -e 0x08040041 -n "Linux-xip" -d $(target_out_linux)/arch/arm/boot/xipuimage $(target_out_linux)/arch/arm/boot/xipuimage.bin))

#make -j 46 -C /media/oem/Data/linux_work/opensource/linux O=build_image/build/linux ARCH=arm KBUILD_DEBARCH= LOCALVERSION=-stm-r1 KDEB_CHANGELOG_DIST=bionic KDEB_PKGVERSION=1stable CROSS_COMPILE=arm-linux-gnueabihf- KDEB_SOURCENAME=linux-upstream LOADADDR=0x8100000 dtbs xipImage
#make -C /media/oem/Data/linux_work/opensource/linux ARCH=arm O=/media/oem/Data/linux_work/build/linux stm32_defconfig
clean-linux:
	make -C $(linux_path) clean