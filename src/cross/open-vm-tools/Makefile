PKG_NAME = open-vm-tools
PKG_VERS = stable-12.5.2
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/vmware/open-vm-tools/archive
PKG_DIST_FILE = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)/$(PKG_NAME)

DEPENDS = cross/glib

HOMEPAGE = https://github.com/vmware/open-vm-tools
COMMENT  = VMware open-vm-tools project
LICENSE  = GPLv2/LGPLv2.1

PRE_CONFIGURE_TARGET = vmtools_pre_configure
INSTALL_TARGET = vmtools_install
POST_INSTALL_TARGET = vmtools_post_install

GNU_CONFIGURE = 1
CONFIGURE_ARGS = 
CONFIGURE_ARGS += --disable-docs
CONFIGURE_ARGS += --disable-tests
CONFIGURE_ARGS += --disable-deploypkg
CONFIGURE_ARGS += --disable-glibc-check
CONFIGURE_ARGS += --disable-containerinfo
CONFIGURE_ARGS += --disable-vgauth

CONFIGURE_ARGS += --without-x
CONFIGURE_ARGS += --without-gtk3
CONFIGURE_ARGS += --without-gtk2
CONFIGURE_ARGS += --without-fuse
CONFIGURE_ARGS += --without-pam
CONFIGURE_ARGS += --without-ssl
CONFIGURE_ARGS += --without-xmlsec1
CONFIGURE_ARGS += --without-xml2
CONFIGURE_ARGS += --without-tirpc
CONFIGURE_ARGS += --without-icu

CONFIGURE_ARGS += --enable-servicediscovery

ENV += PATH=$(STAGING_INSTALL_PREFIX)/bin:$$PATH

include ../../mk/spksrc.cross-cc.mk

.PHONY: vmtools_pre_configure
vmtools_pre_configure:
	@$(RUN) echo -e 'libMisc_la_LDFLAGS =\nlibMisc_la_LDFLAGS += -liconv\n' >> lib/misc/Makefile.am
	@$(RUN) autoreconf -fiv

.PHONY: vmtools_install
vmtools_install:
	@$(RUN) $(MAKE) install DESTDIR=$(STAGING_INSTALL_PREFIX) prefix=""

.PHONY: vmtools_post_install
vmtools_post_install:
	@$(RUN) mv -vf $(STAGING_INSTALL_PREFIX)/usr/bin/vm-support $(STAGING_INSTALL_PREFIX)/bin/
