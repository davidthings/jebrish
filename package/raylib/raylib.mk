################################################################################
#
# raylib https://github.com/raysan5/raylib/archive/refs/tags/5.0.tar.gz
#
################################################################################

#
#  When using DRM - xf86drm.h and xf86drmMode.h point to the wrong drm directory
#  they need `#include <drm/drm.h>`
#

RAYLIB_VERSION = 5.0
RAYLIB_SOURCE = $(RAYLIB_VERSION).tar.gz
RAYLIB_SITE = https://github.com/raysan5/raylib/archive/refs/tags
RAYLIB_INSTALL_STAGING = YES
RAYLIB_INSTALL_TARGET = YES
# RAYLIB_CONF_OPTS = -DPLATFORM=DRM -DBUILD_EXAMPLES=ON -DMAKE_INSTALL_PREFIX=/usr
RAYLIB_CONF_OPTS = -DUSE_WAYLAND=OFF -DBUILD_EXAMPLES=ON -DMAKE_INSTALL_PREFIX=/usr \
                   -DOPENGL_VERSION=2.1 -DGLFW_BUILD_X11=ON 
RAYLIB_DEPENDENCIES = mesa3d libgl wayland libxkbcommon wayland-protocols

define RAYLIB_INSTALL_TARGET_CMDS
    cp -R $(@D)/raylib/lib* $(TARGET_DIR)/usr/lib
    $(INSTALL) -d $(TARGET_DIR)/usr/raylib
    cp -R $(@D)/examples/* $(TARGET_DIR)/usr/raylib
endef

$(eval $(cmake-package))
