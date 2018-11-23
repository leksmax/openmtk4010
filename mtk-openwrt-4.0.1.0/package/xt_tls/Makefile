#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=xt_tls
PKG_VERSION:=3636cd5
PKG_RELEASE:=1
PKG_REV:=3636cd5

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/Lochnair/xt_tls.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/iptables-mod-tls
  SUBMENU:=Firewall
  SECTION:=net
  CATEGORY:=Network
  TITLE:=xt_tls for iptables
  URL:=https://github.com/Lochnair/xt_tls
  DEPENDS:=+iptables +iptables-mod-conntrack-extra
  MAINTAINER:=contact@lochnair.net
endef

define Package/iptables-mod-tls/description
  xt_tls is a encryption of tls hostname classfy.
endef

CONFIGURE_ARGS += --with-pic

#MAKE_PATH:=xt_tls

MAKE_FLAGS += \
	KERNEL_DIR="$(LINUX_DIR)" \
	MODULES_DIR="$(TARGET_MODULES_DIR)"

define Build/Compile
	make $(MAKE_FLAGS) -C $(PKG_BUILD_DIR)/
endef

define Package/iptables-mod-tls/install
	$(INSTALL_DIR) $(1)/usr/lib/iptables
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ipt/libxt_tls.so $(1)/usr/lib/iptables
endef

define KernelPackage/ipt-tls
  SUBMENU:=Netfilter Extensions
  TITLE:= nDPI net netfilter module
  DEPENDS:=+kmod-nf-conntrack +kmod-nf-conntrack-netlink +kmod-ipt-compat-xtables
  FILES:= \
	$(PKG_BUILD_DIR)/src/xt_tls.ko
  AUTOLOAD:=$(call AutoProbe,xt_tls)
endef

$(eval $(call BuildPackage,iptables-mod-tls))
$(eval $(call KernelPackage,ipt-tls))
