################################################################################
#
# raylib https://github.com/raysan5/raylib/archive/refs/tags/5.0.tar.gz
#
################################################################################

#
#  When using DRM - xf86drm.h and xf86drmMode.h point to the wrong drm directory
#  they need `#include <drm/drm.h>`  This is patched in libDRM
#

# This is what worked before
# RAYLIB_CONF_OPTS = -DPLATFORM=DRM -DBUILD_EXAMPLES=ON -DMAKE_INSTALL_PREFIX=/usr
# # RAYLIB_CONF_OPTS = -DUSE_WAYLAND=OFF -DBUILD_EXAMPLES=ON -DMAKE_INSTALL_PREFIX=/usr \
# #                   -DOPENGL_VERSION=2.1 -DGLFW_BUILD_X11=ON 
# RAYLIB_DEPENDENCIES = mesa3d libgl wayland libxkbcommon wayland-protocols


RAYLIB_VERSION = 5.0
RAYLIB_SOURCE = $(RAYLIB_VERSION).tar.gz
RAYLIB_SITE = https://github.com/raysan5/raylib/archive/refs/tags
RAYLIB_INSTALL_STAGING = YES
RAYLIB_INSTALL_TARGET = YES

RAYLIB_CONF_OPTS = -DMAKE_INSTALL_PREFIX=/usr 

RAYLIB_DEPENDENCIES = mesa3d wayland wayland-protocols

ifeq ($(BR2_RAYLIB_BACKEND_DRM),y)
	RAYLIB_CONF_OPTS += -DPLATFORM=DRM -DOPENGL_VERSION="ES 2.0"
# -DGRAPHICS_API_OPENGL_33=1
	RAYLIB_DEPENDENCIES += libegl
endif

ifeq ($(BR2_RAYLIB_BACKEND_X11),y)
	RAYLIB_CONF_OPTS += -DGLFW_BUILD_X11=ON  -DPLATFORM=Desktop -DOPENGL_VERSION=2.1
	RAYLIB_DEPENDENCIES += libxkbcommon libgl 
endif

ifeq ($(BR2_RAYLIB_BUILD_EXAMPLES),y)
	RAYLIB_CONF_OPTS += -DBUILD_EXAMPLES=ON
else 
	RAYLIB_CONF_OPTS += -DBUILD_EXAMPLES=OFF
endif

define RAYLIB_PRE_BUILD_HOOK

#    find $(@D)/examples -name '*.c' -exec grep -l '#define GLSL_VERSION\s\+330' {} + -exec sed -i 's/#define GLSL_VERSION\s\+330/#define GLSL_VERSION            120/' {} +
#    find $(@D)/examples -type f -name '*.c' -exec sed -i "s/const int screenWidth = 800/const int screenWidth = $(BR2_RAYLIB_EXAMPLE_WIDTH)/g" {} +
#    find $(@D)/examples -type f -name '*.c' -exec sed -i "s/const int screenHeight = 450/const int screenHeight = $(BR2_RAYLIB_EXAMPLE_HEIGHT)/g" {} +

endef

# Add the hook to the package's hooks
RAYLIB_PRE_BUILD_HOOKS += RAYLIB_PRE_BUILD_HOOK

define RAYLIB_INSTALL_TARGET_CMDS
    cp -R $(@D)/raylib/lib* $(TARGET_DIR)/usr/lib
    cp -R $(@D)/raylib/include/* $(TARGET_DIR)/usr/include

    $(INSTALL) -d $(TARGET_DIR)/usr/raylib

	# if [[$(BR2_RAYLIB_BUILD_EXAMPLES) == "y" ]]; then
    	cp -R $(@D)/examples/* $(TARGET_DIR)/usr/raylib
	# fi
endef

$(eval $(cmake-package))
