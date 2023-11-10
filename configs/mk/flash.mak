

target_out := $(root_dir)/build

target_out_uboot := $(target_out)/uboot
target_out_linux := $(target_out)/linux
$(info target_out_linux:$(target_out),$(target_out_linux))
target_out_busybox := $(target_out)/busybox
target_out_romfs := $(target_out)/romfs
images_out_dir := $(target_out)/images


uboot_partition_offset := 0 #0x00
linux_dtb_partition_offset := 196608 #0x30000
linux_kernel_partition_offset := 262144 #0x40000
