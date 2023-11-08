#!/bin/sh

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

# Get the dtb's into the image dir somehow
cp output/build/uboot-v2024.01-rc1/u-boot.dtb $BINARIES_DIR

# cp output/build/u-boot/arch/arm/dts/rk3566-anbernic-rgxx3.dtb $BINARIES_DIR
# cp output/build/linux/arch/arm64/boot/dts/rockchip/rk3566-anbernic*.dtb $BINARIES_DIR

sed -e "$(generic_getty)" \
	-e "s/%LINUXIMAGE%/$(linux_image)/g" \
	-e "s/%PARTUUID%/$PARTUUID/g" \
	"board/anbernic/rg353/extlinux.conf" > "$BINARIES_DIR/extlinux/extlinux.conf"

sed "s/%PARTUUID%/$PARTUUID/g" "board/anbernic/rg353/genimage.cfg" > "$BINARIES_DIR/genimage.cfg"

