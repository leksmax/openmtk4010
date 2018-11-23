#
# Copyright (C) 2018 Withus Planet
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=makeContainer
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/makeContainer
  SECTION:=Withus Planet Properties
  CATEGORY:=Withus Planet Properties
  TITLE:=makeContainer
  SUBMENU:=Applications
  DEPENDS:=+libcap +libpthread +libnettle
endef

define Package/makeContainer/description
  makeContainer binary from Raspberry Pi
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/makeContainer/install
	$(INSTALL_DIR) $(1)/root
	$(INSTALL_DIR) $(1)/root/makeContainer
	$(INSTALL_DIR) $(1)/root/makeContainer/chrony
	$(INSTALL_DIR) $(1)/root/makeContainer/dnsmasq
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3/bin
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3/sbin
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3/mibs
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.8
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.8/bin
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.8/sbin
	$(INSTALL_DIR) $(1)/root/makeContainer/net-snmp/net-snmp-5.8/mibs
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/docker
	$(INSTALL_DIR) $(1)/etc/chrony
	$(INSTALL_BIN) ./chrony/run_chrony.sh $(1)/usr/sbin
	$(INSTALL_BIN) ./dnsmasq/run_dnsmasq.sh $(1)/usr/sbin
	$(INSTALL_BIN) ./chrony/* $(1)/root/makeContainer/chrony
	$(INSTALL_BIN) ./dnsmasq/* $(1)/root/makeContainer/dnsmasq
	$(INSTALL_BIN) ./net-snmp/run_net-snmp.sh $(1)/usr/sbin
	$(INSTALL_BIN) ./net-snmp/*.sh $(1)/root/makeContainer/net-snmp
	$(INSTALL_BIN) ./net-snmp/dockerfile* $(1)/root/makeContainer/net-snmp
	$(INSTALL_BIN) ./net-snmp/snmpd.* $(1)/root/makeContainer/net-snmp
	$(INSTALL_BIN) ./net-snmp/net-snmp-5.7.3/sbin/* $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3/sbin
	$(INSTALL_BIN) ./net-snmp/net-snmp-5.8/sbin/* $(1)/root/makeContainer/net-snmp/net-snmp-5.8/sbin
#$(INSTALL_BIN) ./net-snmp/net-snmp-5.7.3/snmp* $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3/bin
#$(INSTALL_BIN) ./net-snmp/net-snmp-5.7.3/mibs/* $(1)/root/makeContainer/net-snmp/net-snmp-5.7.3/mibs
#$(INSTALL_BIN) ./net-snmp/net-snmp-5.8/snmp* $(1)/root/makeContainer/net-snmp/net-snmp-5.8/bin
#$(INSTALL_BIN) ./net-snmp/net-snmp-5.8/mibs/* $(1)/root/makeContainer/net-snmp/net-snmp-5.8/mibs
endef

$(eval $(call BuildPackage,makeContainer))

