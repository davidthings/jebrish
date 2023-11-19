#!/bin/bash

echo "Running post-build.sh"
echo "    TARGET_DIR: $TARGET_DIR"
echo "    HOST_DIR: $HOST_DIR"
echo "    BINARIES_DIR: $BINARIES_DIR"

export -p

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

PARTUUID="$($HOST_DIR/bin/uuidgen)"

install -d "$BINARIES_DIR/extlinux/"
install -d "$BINARIES_DIR/rockchip/"

DTB_SOURCE_DIR="output/build/linux-v6.7-rc1/arch/arm64/boot/dts/rockchip"

DEVICE_DTB="rk3566-anbernic-rg353ps rk3566-anbernic-rg353vs rk3566-anbernic-rg503 rk3566-anbernic-rg353p rk3566-anbernic-rg353v rk3566-powkiddy-rgb30 rk3566-powkiddy-rk2023" 

for DTB in ${DEVICE_DTB} ; do 
    echo "    Copying $DTB_SOURCE_DIR/${DTB}.dtb to $BINARIES_DIR/rockchip"
    cp $DTB_SOURCE_DIR/${DTB}.dtb $BINARIES_DIR/rockchip 
done

sed -e "$(generic_getty)" \
	-e "s/%LINUXIMAGE%/$(linux_image)/g" \
	"board/jebrish/rg353x_mingraph/extlinux.conf" > "$BINARIES_DIR/extlinux/extlinux.conf"

sed -e "s/%LINUXIMAGE%/$(linux_image)/g" \
    "board/jebrish/rg353x_mingraph/genimage.cfg" > "$BINARIES_DIR/genimage.cfg"

