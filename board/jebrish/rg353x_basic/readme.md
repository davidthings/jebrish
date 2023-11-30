# RG353x BASIC

## Overview

A basic, fully functional system.

## Parent Readme

For the parent documentation, see 
- [RG353X minXGraph Doc]( ../rg353x_minxgraph/readme.md)
- [RG353X minWiFi Doc]( ../rg353x_minwifi/readme.md)

## Build

```
  $ make jebrish_rg353x_basic_defconfig
  $ make
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

Password is `1234`

No Window manager is started for now.



