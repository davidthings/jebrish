# RG353x MINIMAL

## Overview

Provides an absolutely minimal system.  There is no rootfs on the disk.

Demonstrates UBoot-SPL, UBoot, and kernel.

## Parent Readme

For the common documentation, see [RG353X Common Doc]( ../rg353x_common/readme.md)

## Build

  $ make jebrish_rg353x_minimal_defconfig
  $ make

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
```

