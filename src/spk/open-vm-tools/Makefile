SPK_NAME = open-vm-tools
SPK_VERS = 12.4.5
SPK_REV = 1
SPK_ICON = src/open-vm-tools.png

DEPENDS = cross/$(SPK_NAME)
UNSUPPORTED_ARCHS = $(PPC_ARCHS) $(ARMv5_ARCHS) $(i686_ARCHS) $(ARMv7L_ARCHS)

MAINTAINER = vmware
DESCRIPTION = open-vm-tools is a set of services and modules that enable several features in VMware products for better management of, and seamless user interactions with, guests. ⚠️安装完毕SSH修复：sudo sed -i 's/package/root/g' /var/packages/open-vm-tools/conf/privilege
RELOAD_UI = yes
DISPLAY_NAME = VMware Tools
CHANGELOG = "SPK Open-vm-tools | 28 Jun 2024 | Build 23787635"

HOMEPAGE = https://github.com/vmware/open-vm-tools
LICENSE  = GPLv2/LGPLv2.1

# 'auto' reserved value grabs SPK_NAME
SERVICE_USER  = auto
SERVICE_SETUP = src/service-setup.sh
CONF_DIR      = src/conf
STARTABLE     = yes

include ../../mk/spksrc.spk.mk
