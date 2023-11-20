# Update uboot
# filesystem_path := $(shell ls $(uboot_path)/.git 2>/dev/null)
# ifeq ($(strip $(filesystem_path)),)
# $(info *** Clone u-boot source ***)
# $(info $(shell git clone ${uboot_remote_url} ${uboot_path}))
# endif
# $(info $(shell git -C ${uboot_path} fetch))
# git_commit := $(shell git -C ${uboot_path} rev-parse --quiet --verify ${uboot_version})
# $(info $(shell git -C ${uboot_path} checkout --detach ${git_commit}))


# #Update linux
# filesystem_path := $(shell ls $(linux_path)/.git 2>/dev/null)
# ifeq ($(strip $(filesystem_path)),)
# $(info *** Clone linux source ***)
# $(info $(shell git clone ${linuxremote_url} ${linux_path}))
# endif
# $(info $(shell git -C ${linux_path} fetch))
# git_commit := $(shell git -C ${linux_path} rev-parse --quiet --verify ${linux_version})
# $(info $(shell git -C ${linux_path} checkout --detach ${git_commit}))


update-uboot:
	$(info $(shell python3 $(root_dir)/configs/script/git_checkout.py -r $(uboot_remote_url) -l $(uboot_path) -m $(uboot_version)))

update-linux:
	$(info $(shell python3 $(root_dir)/configs/script/git_checkout.py -r $(linux_remote_url) -l $(linux_path) -m $(linux_version)))

update-busybox:
	$(shell mkdir -p ${busybox_path})
	$(info $(shell wget -P $(opensource_path) -c $(busybox_url)/$(busybox_version).tar.bz2))
	$(info $(shell tar -jxf $(opensource_path)/${busybox_version}.tar.bz2 -C $(busybox_path)))

update-opensource: update-uboot update-linux
