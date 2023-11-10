SHELL := /bin/bash
root_dir := $(shell pwd)
CROSS_COMPILE ?= arm-linux-gnueabihf-

include configs/sources
include configs/defs


TARGETS := $(uboot_target) $(linux_target) $(rootfs_target)


build: build-linux build-uboot generate-image

all: update build

update: update-opensource

generate-image: build-linux build-uboot
	$(shell mkdir -p ${images_out_dir})
	$(shell cp $(uboot_target) $(images_out_dir))
	$(shell cp $(linux_target) $(images_out_dir))
	$(shell cp $(linux_dtb_target) $(images_out_dir))
	$(shell cp $(images_out_dir)/$(uboot_binary_name) $(images_out_dir)/$(uboot_with_dtb_binary_name) )
	$(info $(shell dd if=$(images_out_dir)/$(kernel_dtb_name) of=$(images_out_dir)/$(uboot_with_dtb_binary_name) bs=1 seek=$(linux_dtb_partition_offset) conv=notrunc))

flash-uboot:
	$(info $(shell st-flash --format binary write $(images_out_dir)/$(uboot_with_dtb_binary_name) $(flash_load_hex_address)))

flash-linux:
	$(info linux_kernel_hex_address:$(linux_kernel_hex_address))
	$(info $(shell st-flash --format binary write $(images_out_dir)/$(kernel_binary_name) $(linux_kernel_hex_address)))

flash: flash-uboot flash-linux

distclean:
	rm -rf $(target_out)

include configs/mk/download.mak
include configs/mk/linux.mak
include configs/mk/uboot.mak
