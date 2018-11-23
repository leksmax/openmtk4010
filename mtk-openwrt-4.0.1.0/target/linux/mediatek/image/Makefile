#
# Copyright (C) 2012-2015 OpenWrt.org
# Copyright (C) 2016-2017 LEDE project
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# build dtb
define Build/dtb
        $(call Image/BuildDTB,$(DEVICE_DTS_DIR)/$(DEVICE_DTS).dts,$(DEVICE_DTS_DIR)/$(DEVICE_DTS).dtb)
	$(CP) $(DEVICE_DTS_DIR)/$(DEVICE_DTS).dtb $(BIN_DIR)/
endef

# default all platform image(fit) build
define Device/Default
  PROFILES = Default $$(DEVICE_NAME)
  KERNEL_NAME := Image
  FILESYSTEMS := squashfs
  DEVICE_DTS_DIR := $(DTS_DIR)
  KERNEL = dtb | kernel-bin | lzma | fit lzma $$(DEVICE_DTS_DIR)/$$(DEVICE_DTS).dtb
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | pad-to 128k | append-rootfs | pad-rootfs | append-metadata
endef

include $(SUBTARGET).mk

$(eval $(call BuildImage))

