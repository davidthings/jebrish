ANBERNIC RG353x
===============

Build:
======
  $ make anbernic_rg353_defconfig
  $ make

Files created in output directory
=================================

output/images
|
+--rootfs.ext2
+--rootfs.ext4 -> rootfs.ext2
+--u-boot.bin
+--u-boot-spl.bin


Creating bootable SD card:
==========================

sudo dd if=output/images/sdcard.img of=/dev/sdX && sync

Where X is your SD card device.

Booting:
========

Serial console:
---------------

ttyS2 - 1500000n81

The boot order on RK35xx is emmc, sd. If emmc contains a valid Image, the board
always boots from emmc. To boot from SD, erase emmc 

Login:
------
Enter 'root' as login user, and the prompt is ready.

wiki link:
----------
