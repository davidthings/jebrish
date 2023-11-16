# RG353x MINWIFI

## Overview

The absolutely minimal system with a permanent (mutable) ext4 root file system.

On first boot, it is resized by init to fill the available partition.

## Parent Readme

For the common documentation, see [RG353X MinFs Doc]( ../rg353x_minfs/readme.md)

## Build

  $ make jebrish_rg353x_minwifi_defconfig
  $ make

## Input Files

The unique input files are

```
configs/jebrish_rg353x_minwifi_defconfig
```

