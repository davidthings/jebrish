#!/bin/sh

BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BINARIES_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

echo "Running post-image.sh"
echo "    BOARD_DIR: $BOARD_DIR"
echo "    GENIMAGE_CFG: $GENIMAGE_CFG"
echo "    GENIMAGE_TMP: $GENIMAGE_TMP"
echo "    TARGET_DIR: $TARGET_DIR"
echo "    HOST_DIR: $HOST_DIR"
echo "    BINARIES_DIR: $BINARIES_DIR"

rm -rf "${GENIMAGE_TMP}"

${HOST_DIR}/bin/genimage           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"     \
    --configdump -

exit $?
