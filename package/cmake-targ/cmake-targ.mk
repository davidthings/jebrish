################################################################################
#
# CMake Target
#
################################################################################

CMAKE_TARG_VERSION = 3.28.2
CMAKE_TARG_SITE = $(call github,kitware,cmake,v$(CMAKE_TARG_VERSION))
CMAKE_TARG_INSTALL_STAGING = YES
CMAKE_TARG_INSTALL_TARGET = YES

$(eval $(cmake-package))

