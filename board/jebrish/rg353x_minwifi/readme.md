# RG353x MINWIFI

## Overview

The absolutely minimal system with a permanent (mutable) ext4 root file system and wifi.  SSH and mDNS are provided.

## Parent Readme

For the parent documentation, see [RG353X MinFs Doc]( ../rg353x_minfs/readme.md)

## Build

  $ make jebrish_rg353x_minwifi_defconfig
  $ make

## Input Files

The unique input files are

```
configs/jebrish_rg353x_minwifi_defconfig
```

Network setup files.  

```
board/jebrish/rg353x_minwifi/rootfs-overlay/etc/wpa_supplicant.conf
board/jebrish/rg353x_minwifi/rootfs-overlay/etc/init.d/S35rtw88
board/jebrish/rg353x_minwifi/rootfs-overlay/etc/init.d/S36wpa
```

## Operation

After building and creating the SD card, `/etc/wpa_supplicant.conf` should be edited to include the wifi credentials.

On first boot, the file system is resized by init to fill the available partition.

On all boots, the networking and wifi system is configured by init.

The system boots to a login prompt on the console and ssh via wifi is available.

The device is made easy to find on the network by mDNS.  The hostname is `JEBRG353`, which permits simple location, provided both the main machine and and device are on the same network.

```
ssh root@jeb_rg353.local
```



