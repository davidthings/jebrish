# RG353x MINGRAPH

## Overview

Provides Weston and Wayland on a minimal system.  There is no rootfs on the disk.

Demonstrates DRM-based UI on the panel and on the HDMI port.

## Parent Readme

For the common documentation, see [RG353X Minimal Doc]( ../rg353x_minimal/readme.md)

## Build

```
  $ make jebrish_rg353x_mingraph_defconfig
  $ make
```

## Operation

Until this is made automatic, you must do a little setup


```
export XDG_RUNTIME_DIR=/var/weston
export WAYLAND_DISPLAY=wayland-1
```

```
weston --backend=drm --shell=kiosk --no-config
```

## Input Files

The unique input files are

```
configs/jebrish_rg353x_minimal_defconfig
```

```
board/jebrish/rg353x_minimal
|
+ extlinux.conf   # minimal kernel args (no rootfs reference)
+ genimage.cfg    # minimal genimage config (boot partition only, not rootfs)
+ post-build.sh   # no s/// substitutions for rootfs
+ rootfs-overlay/ 
    |
    + root    
    |  |
    |  + .config
    |     |
    |     + weston.ini
    + var
       |
       + weston 

```

## To Do

Make the weston start automatic

Tune the .ini file.  Right now it's rubbish.
