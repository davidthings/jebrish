# POWKIDDY X55 MINIMAL

## Overview

Provides an absolutely minimal system.  There is no initramfs, no rootfs expansion.

Demonstrates UBoot-SPL, UBoot, and kernel.

## Parent Readme

For the common documentation, see [Common Doc]( ../rg353x_common/readme.md)

## Build

  $ make powkiddy_x55_minimal_defconfig
  $ make

## Input Files

The unique input files are

exlinux.conf

genimage.cffg

post-build.sh



