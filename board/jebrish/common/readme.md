# COMMON

## Purpose

Common files for all the JEBRISH devices

Some may be overridden by the more specific files

These Common files assume a normal file system
- initramfs
- rootfs (ext4)

So the minimal configs will need to override these

## To Do

Many configs should point here rather than rg353x_common

## Input Files

The unique input files are

```
board/jebrish/common
  |
  + linux-patches  # patches to apply to the kernel
  + uboot-patches  # patches to apply to uboot
  + extlinux.conf  # kernel args 
  + genimage.cfg   # genimage config 
  + linux.config   # kernel config (there may be others here too)
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
