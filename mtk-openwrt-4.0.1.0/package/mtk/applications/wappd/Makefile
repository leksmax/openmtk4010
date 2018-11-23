#
# hua.shao@mediatek.com
#
# MTK Property Software.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wappd
PKG_REVISION:=0c7c55fd
PKG_SOURCE:=$(PKG_NAME)-$(PKG_REVISION).tar.bz2
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

TARGET_CFLAGS += -DCONFIG_SUPPORT_OPENWRT
MAKE_FLAGS += CONFIG_SUPPORT_OPENWRT=y

define Package/wapp
  SECTION:=MTK Properties
  CATEGORY:=MTK Properties
  TITLE:=wapp daemon
  SUBMENU:=Applications
#  DEPENDS:= +libpthread +librt
endef

define Package/wapp/description
  wifi app daemon
endef


#MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)"

define Package/wapp/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/wappctrl $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/wapp $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/wapp_openwrt.sh $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mbo_nr.sh $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_ra0_default.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_ra0_default.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_ra0.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_ra1.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap2.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_rai0_default.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_rai0.conf $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wapp_ap_rai1.conf $(1)/etc_ro
#PF5
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/wifi-abgn-logo_270x73.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_blue_eng_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_blue_zxx_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_blue_eng.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_blue_zxx.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_green_eng_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_green_zxx_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_green_eng.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_green_zxx.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_orange_eng_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_orange_zxx_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_orange_eng.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_orange_zxx.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_red_eng_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_red_zxx_default.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_red_eng.png $(1)/etc_ro
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/config_and_icon_files/icon_red_zxx.png $(1)/etc_ro
#install init to run wapp_openwrt.sh at bootup
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/wappd.init $(1)/etc/init.d/wappd
endef

$(eval $(call BuildPackage,wapp))

