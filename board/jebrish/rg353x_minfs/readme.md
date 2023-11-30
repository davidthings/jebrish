# RG353x MINFS

## Overview

The absolutely minimal system with a permanent (mutable) ext4 root file system.

No resize on first boot takes place since it is mounted from the very start.

## Parent Readme

For the common documentation, see [RG353X Common Doc]( ../rg353x_common/readme.md)

## Build

  $ make jebrish_rg353x_minfs_defconfig
  $ make

## Input Files

The unique input files are the main config

```
configs/jebrish_rg353x_minfs_defconfig
```

And the new init script and a flag file saying that the file system needs to be expanded

```
board/jebrish/rg353x_minfs/rootfs-overlay/init
board/jebrish/rg353x_minfs/rootfs-overlay/.RELEASE_ME
```



