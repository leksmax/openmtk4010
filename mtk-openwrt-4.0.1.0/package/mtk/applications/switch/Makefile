#
# hua.shao@mediatek.com
#
# MTK Property Software.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=switch
PKG_REVISION:=2cdaa1b9
PKG_SOURCE:=$(PKG_NAME)-$(PKG_REVISION).tar.gz
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_KCONFIG:=RALINK_MT7620 RALINK_MT7621 RALINK_MT7628 MACH_MT7623 GE1_SGMII_FORCE_2500 SUPPORT_OPENWRT
PKG_CONFIG_DEPENDS:=$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)))

define Package/switch
  SECTION:=MTK Properties
  CATEGORY:=MTK Properties
  TITLE:=Command to config switch
  SUBMENU:=Applications
endef

define Package/switch/description
  An program to config switch.
endef

TARGET_CFLAGS += \
	$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),-DCONFIG_$(c)=$(CONFIG_$c))) 

MAKE_FLAGS += \
	$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)=$(CONFIG_$c))) 

ifeq ($(CONFIG_TARGET_mediatek),y)
TARGET_CFLAGS += \
	-I$(LINUX_DIR)/drivers/net/ethernet/raeth 
else
TARGET_CFLAGS +=  \
	-I$(LINUX_DIR)/drivers/net/raeth
endif


define Build/Configure
endef


define Package/switch/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/lib/network
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/switch $(1)/usr/bin
ifeq ($(CONFIG_TARGET_ramips_mt7620),y)
	$(INSTALL_BIN) ./files/switch-7620.sh $(1)/lib/network/switch.sh
endif
ifeq ($(CONFIG_TARGET_ramips_mt7628),y)
	$(INSTALL_BIN) ./files/switch-7628.sh $(1)/lib/network/switch.sh
endif
ifeq ($(CONFIG_TARGET_ramips_mt7688),y)
	$(INSTALL_BIN) ./files/switch-7628.sh $(1)/lib/network/switch.sh
endif
ifeq ($(CONFIG_TARGET_ramips_mt7621),y)
	$(INSTALL_BIN) ./files/switch-7621.sh $(1)/lib/network/switch.sh
endif
endef

$(eval $(call BuildPackage,switch))
