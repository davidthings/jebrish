# RG353X COMMON

## Purpose

Common files for all the RG353x devices.

## Build

  $ make jebrish_rg353x_[]_defconfig
  $ make

## Input Files

The unique input files are

```
configs/jebrish_rg353x_minfs_defconfig
```

```
board/jebrish/rg353x_common
|
+ extlinux.conf  # kernel args 
+ genimage.cfg   # genimage config 
+ linux.config   # kernel config
+ uboot.config   # uboot config
+ post-build.sh  # copy files for the boot partition, setup genimage.cfg
+ post-image.sh  # invoke genimage to create sdcard.img
+ rootfs-overlay # files to copy over the rootfs
  |
  + init         # init with switch_root 
```

## Output Files

```
output/images
|
+--sdimage.img
```

## Creating bootable SD card

sudo dd if=output/images/sdcard.img of=/dev/X ; sync

Where X is your SD card device.

## Booting

Whether the console appears on the UART or on the main display is controlled by the `console` command order in `extlinux.conf`.  The last one referenced is the one that appears with a shell.

### Serial console

ttyS2 - 1500000n81

### Main console

The console should appear on the LCD and HDMI.

A USB keyboard is required.

### Login

User:root

Password:1234
