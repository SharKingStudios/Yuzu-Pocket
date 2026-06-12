#!/usr/bin/env sh
set -eu

board_dir="${BR2_EXTERNAL_YUZU_POCKET_PATH}/board/yuzu-pocket"
genimage_tmp="${BUILD_DIR}/genimage.tmp"

rm -rf "$genimage_tmp"

mkdir -p "${BINARIES_DIR}/extlinux"
cp "${TARGET_DIR}/boot/extlinux/extlinux.conf" "${BINARIES_DIR}/extlinux/extlinux.conf"
cp "${TARGET_DIR}/boot/HOW_TO_USE.txt" "${BINARIES_DIR}/HOW_TO_USE.txt"
cp "${TARGET_DIR}/opt/yuzu-pocket/help/YUZU_POCKET_TERMINAL.url" "${BINARIES_DIR}/YUZU_POCKET_TERMINAL.url"
cp "${TARGET_DIR}/opt/yuzu-pocket/help/YUZU_POCKET_TERMINAL.webloc" "${BINARIES_DIR}/YUZU_POCKET_TERMINAL.webloc"

genimage \
	--rootpath "${TARGET_DIR}" \
	--tmppath "$genimage_tmp" \
	--inputpath "${BINARIES_DIR}" \
	--outputpath "${BINARIES_DIR}" \
	--config "${board_dir}/genimage/genimage.cfg"
