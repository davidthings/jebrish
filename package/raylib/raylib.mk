################################################################################
#
# raylib https://github.com/raysan5/raylib/archive/refs/tags/5.0.tar.gz
#
################################################################################

RAYLIB_VERSION = 5.0
RAYLIB_SOURCE = $(RAYLIB_VERSION).tar.gz
RAYLIB_SITE = https://github.com/raysan5/raylib/archive/refs/tags
RAYLIB_INSTALL_STAGING = YES
RAYLIB_INSTALL_TARGET = YES
RAYLIB_CONF_OPTS = -DUSE_WAYLAND=ON -DBUILD_EXAMPLES=ON -DGLFW_BUILD_X11=OFF
RAYLIB_DEPENDENCIES = mesa3d libgl wayland libxkbcommon wayland-protocols

define RAYLIB_INSTALL_TARGET_CMDS
    $(INSTALL) -d $(TARGET_DIR)/usr/raylib
    cp -R $(@D)/examples/* $(TARGET_DIR)/usr/raylib
endef

$(eval $(cmake-package))
