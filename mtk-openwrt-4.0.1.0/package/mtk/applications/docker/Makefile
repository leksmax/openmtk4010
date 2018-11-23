#
# Copyright (C) 2018 Withus Planet
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=docker
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/docker
  SECTION:=Withus Planet Properties
  CATEGORY:=Withus Planet Properties
  TITLE:=docker
  SUBMENU:=Applications
endef

define Package/docker/description
  Docker binary from Raspberry Pi
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/docker/install
	$(INSTALL_DIR) $(1)/root
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/docker
	$(INSTALL_BIN) ./files/Dockerfile $(1)/root
	$(INSTALL_BIN) ./files/hello-world.sh $(1)/root
	$(INSTALL_BIN) ./files/build-hello.sh $(1)/root
	$(INSTALL_BIN) ./files/run-hello.sh $(1)/root
	$(INSTALL_BIN) ./files/docker* $(1)/usr/bin
	$(INSTALL_BIN) ./files/daemon.json $(1)/etc/docker
endef

$(eval $(call BuildPackage,docker))

