#!/bin/sh

BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BINARIES_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

ROOTDRIVE="/dev/mmcblk0p2"

echo "Running post-image.sh"
echo "    BOARD_DIR: $BOARD_DIR"
echo "    GENIMAGE_CFG: $GENIMAGE_CFG"
echo "    GENIMAGE_TMP: $GENIMAGE_TMP"
echo "    TARGET_DIR: $TARGET_DIR"
echo "    HOST_DIR: $HOST_DIR"
echo "    BINARIES_DIR: $BINARIES_DIR"

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

rm -rf "${GENIMAGE_TMP}"

# Originally, the partuuid was created here...
# PARTUUID="$($HOST_DIR/bin/uuidgen)"

PARTUUID=$(dumpe2fs "$BINARIES_DIR/rootfs.ext2" 2>/dev/null | sed -n 's/^Filesystem UUID: *\(.*\)/\1/p')

echo "    PARTUUID: $PARTUUID"

sed -e "$(generic_getty)" \
	-e "s/%LINUXIMAGE%/$(linux_image)/g" \
	-e "s|%ROOTDRIVE%|$ROOTDRIVE|g" \
	-e "s/%PARTUUID%/$PARTUUID/g" \
	"board/jebrish/extlinux_configs/extlinux_no_uuid.conf" > "$BINARIES_DIR/extlinux/extlinux.conf"

sed -e "s/%PARTUUID%/$PARTUUID/g" \
	-e "s/%LINUXIMAGE%/$(linux_image)/g" \
    "board/jebrish/genimage_configs/genimage.cfg" > "$BINARIES_DIR/genimage.cfg"

${HOST_DIR}/bin/genimage           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"     \
    --configdump -

exit $?
