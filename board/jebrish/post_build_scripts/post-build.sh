#!/bin/bash

echo "Running post-build.sh"
echo "    TARGET_DIR: $TARGET_DIR"
echo "    HOST_DIR: $HOST_DIR"
echo "    BINARIES_DIR: $BINARIES_DIR"

# export -p

linux_image()
{
	if grep -Eq "^BR2_LINUX_KERNEL_UIMAGE=y$" ${BR2_CONFIG}; then
		echo "uImage"
	elif grep -Eq "^BR2_LINUX_KERNEL_IMAGE=y$" ${BR2_CONFIG}; then
		echo "Image"
	elif grep -Eq "^BR2_LINUX_KERNEL_IMAGEGZ=y$" ${BR2_CONFIG}; then
		echo "Image.gz"
	else
		echo "zImage"
	fi
}

generic_getty()
{
	if grep -Eq "^BR2_TARGET_GENERIC_GETTY=y$" ${BR2_CONFIG}; then
		echo ""
	else
		echo "s/\s*console=\S*//"
	fi
}

# Originally, the partuuid was created here...
# PARTUUID="$($HOST_DIR/bin/uuidgen)"

# PARTUUID=$(dumpe2fs "$BINARIES_DIR/rootfs.ext2" 2>/dev/null | sed -n 's/^Filesystem UUID: *\(.*\)/\1/p')

# echo "    PARTUUID: $PARTUUID"

install -d "$BINARIES_DIR/extlinux/"
install -d "$BINARIES_DIR/rockchip/"

DTB_SOURCE_DIR="output/build/linux-custom/arch/arm64/boot/dts/"

for DTB in ${BR2_LINUX_KERNEL_INTREE_DTS_NAME} ; do 
    echo "    Copying $DTB_SOURCE_DIR/${DTB}.dtb to $BINARIES_DIR"
    cp $DTB_SOURCE_DIR/${DTB}.dtb $BINARIES_DIR/ 
done

# sed -e "$(generic_getty)" \
# 	-e "s/%LINUXIMAGE%/$(linux_image)/g" \
# #	-e "s/%PARTUUID%/$PARTUUID/g" \
# 	"board/jebrish/extlinux_configs/extlinux.conf" > "$BINARIES_DIR/extlinux/extlinux.conf"

# sed -e "s/%LINUXIMAGE%/$(linux_image)/g" \
# #   -e "s/%PARTUUID%/$PARTUUID/g" \
#     "board/jebrish/genimage_configs/genimage.cfg" > "$BINARIES_DIR/genimage.cfg"

