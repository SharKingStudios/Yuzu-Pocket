#!/usr/bin/env sh
set -eu

cd "$(dirname "$0")/.."

if [ ! -d buildroot ]; then
	echo "Missing Firmware/buildroot. Run ./scripts/fetch-buildroot.sh first." >&2
	exit 1
fi

srcdir="$PWD"
workdir="$srcdir"

case "$srcdir" in
	*" "*)
		workdir="${YUZU_FW_WORKDIR:-$HOME/yuzu-pocket-firmware-work}"
		mkdir -p "$workdir"
		rsync -a --delete \
			--exclude output \
			--exclude debug \
			--exclude buildroot/Pocket \
			"$srcdir/" "$workdir/"
		;;
esac

make -C "$workdir/buildroot" \
	BR2_EXTERNAL="$workdir" \
	BR2_DEFCONFIG="$workdir/configs/yuzu_pocket_defconfig" \
	O="$workdir/output/yuzu_pocket" \
	defconfig

if [ "${1:-}" = "defconfig" ]; then
	echo "Config: $workdir/output/yuzu_pocket/.config"
	exit 0
fi

make -C "$workdir/buildroot" \
	BR2_EXTERNAL="$workdir" \
	O="$workdir/output/yuzu_pocket"

if [ "$workdir" != "$srcdir" ] && [ -d "$workdir/output/yuzu_pocket/images" ]; then
	mkdir -p "$srcdir/output/yuzu_pocket/images"
	rsync -a "$workdir/output/yuzu_pocket/images/" "$srcdir/output/yuzu_pocket/images/"
fi

echo "Image: $srcdir/output/yuzu_pocket/images/sdcard.img"
