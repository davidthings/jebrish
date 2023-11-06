#!/bin/bash

# What am I doing wrong here?
# Guess I can try using buildroot.

DEVICE=$1

[ -z "$DEVICE" ] && echo "please specify device" && exit 1
sudo umount ${DEVICE}*

DEVP=""
if [[ "$DEVICE" == *"loop"* ]]; then
  echo "Loop device detected."
  DEVP="p"
fi

echo "Zeroing device"
dd if=/dev/zero of=$DEVICE bs=1M count=32

echo "Making GPT label"
parted -s $DEVICE mklabel gpt

echo "Creating rockchip bootloader partitions"
# Only this one seems to be required
parted -s $DEVICE unit s mkpart uboot 16384 24575

echo "Creating boot partition"
parted -s $DEVICE -a min unit s mkpart boot fat32 32768 262143
BOOT=2
parted -s $DEVICE set $BOOT boot on
mkfs.fat ${DEVICE}$DEVP$BOOT

echo "Creating rootfs"
parted -s $DEVICE -a min unit s mkpart rootfs ext4 262144 100%
ROOT=3
mkfs.ext4 ${DEVICE}$DEVP$ROOT

# echo "Copying rootfs files"
# mkdir devroot
# sync
# mount ${DEVICE}$DEVP$ROOT devroot
# echo "Copying Arch rootfs"
# ROOTFS=../archroot/rootfs/
# rsync -a --info=progress2 $ROOTFS devroot/
# sync
# echo "Copying kernel modules"
# rsync -a linux/modules_build/ devroot/usr/
# sync
# umount devroot
# sync
# rmdir devroot

echo "Writing rk3566_ddr_1056MHz_v1.18.bin..."
dd if=output/images/rk3566_ddr_1056MHz_v1.18.bin of=$DEVICE seek=64 status=progress

echo "Mounting boot partition"
mkdir tmp
sync
mount ${DEVICE}$DEVP$BOOT tmp
echo "Copying kernel"
cp output/images/Image tmp/Image
zstd -c10 tmp/Image > tmp/Image.zst

# TODO: uboot set reset gpio?

echo "Creating extlinux.conf"
mkdir tmp/extlinux
echo "LABEL linux" >> tmp/extlinux/extlinux.conf
echo "  LINUX /Image.zst" >> tmp/extlinux/extlinux.conf
echo "  FDTDIR /boot/" >> tmp/extlinux/extlinux.conf
UUID=$(blkid -o value -s PARTUUID ${DEVICE}$DEVP$ROOT)
echo "  APPEND console=uart8250,mmio32,0xfe660000 console=tty0 root=PARTUUID=$UUID rw rootwait rootfstype=ext4 init=/sbin/init video=DSI-1:640x480@60" >> tmp/extlinux/extlinux.conf

echo "Copying devicetree files"
mkdir -p tmp/boot/rockchip
cp output/build/uboot-v2024.01-rc1/arch/arm/dts/rk3566-anbernic-rgxx3.dtb tmp/
cp output/build/linux-6.5.5/arch/arm64/boot/dts/rockchip/rk3566-anbernic*.dtb tmp/boot/rockchip/

echo "Unmounting boot partition"
sync
umount tmp
rmdir tmp

echo "Done."
