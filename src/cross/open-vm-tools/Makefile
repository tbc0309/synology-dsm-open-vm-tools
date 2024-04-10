PKG_NAME = open-vm-tools
PKG_VERS = 12.4.0
PKG_BUILD = 23259341
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS)-$(PKG_BUILD).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/vmware/open-vm-tools/releases/download/stable-$(PKG_VERS)
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)-$(PKG_BUILD)

DEPENDS = cross/glib cross/curl cross/moreutils cross/protobuf cross/openssl cross/libmspack cross/fuse3 cross/libtirpc cross/procps-ng cross/libicu cross/libiconv

HOMEPAGE = https://github.com/vmware/open-vm-tools
COMMENT  = VMware open-vm-tools project
LICENSE  = GPLv2/LGPLv2.1

PRE_CONFIGURE_TARGET = vmtools_pre_configure
INSTALL_TARGET = vmtools_install
POST_INSTALL_TARGET = vmtools_post_install

ENV += PATH=$(STAGING_INSTALL_PREFIX)/bin:$$PATH

GNU_CONFIGURE = 1
CONFIGURE_ARGS = 
CONFIGURE_ARGS += --with-fuse=auto
CONFIGURE_ARGS += --without-x
CONFIGURE_ARGS += --without-pam
CONFIGURE_ARGS += --without-xmlsec1
CONFIGURE_ARGS += --enable-servicediscovery
CONFIGURE_ARGS += --enable-containerinfo=no

include ../../mk/spksrc.cross-cc.mk

.PHONY: vmtools_pre_configure
vmtools_pre_configure:
	$(RUN) echo -e 'libMisc_la_LDFLAGS =\nlibMisc_la_LDFLAGS += -liconv\n' >> lib/misc/Makefile.am
	$(RUN) autoreconf -fiv

.PHONY: vmtools_install
vmtools_install:
	$(RUN) $(MAKE) install DESTDIR=$(STAGING_INSTALL_PREFIX) prefix=""

.PHONY: vmtools_post_install
vmtools_post_install:
	# chmod a-x $(STAGING_INSTALL_PREFIX)/etc/pam.d/*
	# chmod a-x $(STAGING_INSTALL_PREFIX)/etc/vmware-tools/*.conf.example
	# chmod a-x $(STAGING_INSTALL_PREFIX)/usr/lib/udev/rules.d/99-vmware-scsi-udev.rules
	# mv $(STAGING_INSTALL_PREFIX)/usr/bin/vm-support $(STAGING_INSTALL_PREFIX)/bin/
