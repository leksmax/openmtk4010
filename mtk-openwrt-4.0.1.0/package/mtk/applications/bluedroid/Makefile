#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bluedroid
PKG_REVISION:=mp
PKG_SOURCE:=$(PKG_NAME)-$(PKG_REVISION).tar.gz
PKG_VERSION:=6.0.0


include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/bluedroid
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=mtk bluedroid library
  DEPENDS:=+zlib +libstdcpp
endef

define Package/bluedroid/description
  mtk bluedroid library
endef



MAKE_FLAGS += CONFIG_SUPPORT_OPENWRT=y CONFIG_USER_GATT_APCLI=y

define Build/Compile
	echo "MAKE_FLAGS:"$(MAKE_FLAGS)
	$(MAKE) -C $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/script/ $(MAKE_FLAGS)
endef

define Build/InstallDev
	mkdir -p $(1)/usr/include
	$(CP)	$(PKG_BUILD_DIR)/bt_others/bluetooth_mw/inc/*.* \
		$(1)/usr/include/
	mkdir -p $(1)/usr/include/config
	$(CP)	$(PKG_BUILD_DIR)/bt_others/bluetooth_mw/inc/config/*.* \
		$(1)/usr/include/config
	mkdir -p $(1)/usr/lib
	$(CP)   $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/prebuilts/lib/*.so $(1)/usr/lib/
endef

define Package/bluedroid/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/prebuilts/lib/*.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP)   $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/prebuilts/bin/btmw-test $(1)/usr/bin/
	$(CP)   $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/prebuilts/bin/picus $(1)/usr/bin/
	mkdir -p $(1)/etc/bluedroid
	$(INSTALL_DIR) $(1)/etc/bluedroid
	$(CP)   $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/prebuilts/conf/bt_stack.conf $(1)/etc/bluedroid/
	$(CP)   $(PKG_BUILD_DIR)/bt_others/bluetooth_tool/prebuilts/conf/bt_did.conf $(1)/etc/bluedroid/
endef

$(eval $(call BuildPackage,bluedroid))
