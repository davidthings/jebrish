################################################################################
#
# raylib https://github.com/raysan5/raylib/archive/refs/tags/5.0.tar.gz
#
################################################################################

#
#  When using DRM - xf86drm.h and xf86drmMode.h point to the wrong drm directory
#  they need `#include <drm/drm.h>`  This is patched in libDRM
#

RAYMINAPP_VERSION = main
RAYMINAPP_SITE = $(call github,davidthings,rayminapp,$(RAYMINAPP_VERSION))
RAYMINAPP_INSTALL_STAGING = YES
RAYMINAPP_INSTALL_TARGET = YES

RAYMINAPP_CONF_OPTS = -DMAKE_INSTALL_PREFIX=/usr 

RAYMINAPP_DEPENDENCIES = raylib mesa3d wayland wayland-protocols

ifeq ($(BR2_RAYLIB_BACKEND_DRM),y)
	RAYMINAPP_CONF_OPTS += -DPLATFORM=DRM -DOPENGL_VERSION="ES 2.0"
	RAYMINAPP_DEPENDENCIES += libegl
endif

ifeq ($(BR2_RAYLIB_BACKEND_X11),y)
	RAYMINAPP_CONF_OPTS += -DGLFW_BUILD_X11=ON  -DPLATFORM=Desktop -DOPENGL_VERSION=2.1
	RAYMINAPP_DEPENDENCIES += libxkbcommon libgl 
endif

define RAYMINAPP_PRE_BUILD_HOOK

    # find $(@D) -type f -name '*.cpp' -exec sed -i "s/#define GLSL_VERSION 330/#define GLSL_VERSION 100/g" {} +
    # find $(@D) -type f -name '*.cpp' -exec sed -i "s/#define GLSL_VERSION 120/#define GLSL_VERSION 100/g" {} +

    find $(@D) -type f -name '*.cpp' -exec sed -i "s/const int screenWidth = 800/const int screenWidth = $(BR2_RAYMINAPP_WIDTH)/g" {} +
    find $(@D) -type f -name '*.cpp' -exec sed -i "s/const int screenHeight = 450/const int screenHeight = $(BR2_RAYMINAPP_HEIGHT)/g" {} +

endef

# Add the hook to the package's hooks
RAYMINAPP_PRE_BUILD_HOOKS += RAYMINAPP_PRE_BUILD_HOOK

define RAYMINAPP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/rayminapp
    cp $(@D)/rayminapp $(TARGET_DIR)/usr/rayminapp
    cp -R $(@D)/resources $(TARGET_DIR)/usr/rayminapp
endef

$(eval $(cmake-package))
