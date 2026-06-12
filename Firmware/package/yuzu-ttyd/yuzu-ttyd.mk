################################################################################
#
# yuzu-ttyd
#
################################################################################

YUZU_TTYD_VERSION = 1.7.7
YUZU_TTYD_SITE = $(call github,tsl0922,ttyd,$(YUZU_TTYD_VERSION))
YUZU_TTYD_LICENSE = MIT
YUZU_TTYD_LICENSE_FILES = LICENSE
YUZU_TTYD_DEPENDENCIES = host-pkgconf json-c libuv libwebsockets zlib

$(eval $(cmake-package))

