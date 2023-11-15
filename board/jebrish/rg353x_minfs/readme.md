# RG353x MIN_FS

# Build

  $ make jebrish_rg353x_minimal_defconfig
  $ make

# Files

output/images
|
+--sdimage.img


# Creating bootable SD card

sudo dd if=output/images/sdcard.img of=/dev/X ; sync

Where X is your SD card device.

# Booting

## Serial console:

ttyS2 - 1500000n81

The boot order on RK35xx is emmc, sd. If emmc contains a valid Image, the board
always boots from emmc. To boot from SD, erase emmc 

## Login

User:root

Password:1234
