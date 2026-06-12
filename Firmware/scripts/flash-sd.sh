#!/usr/bin/env sh
set -eu

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 /dev/sdX" >&2
	exit 1
fi

dev="$1"
img="$(dirname "$0")/../output/yuzu_pocket/images/sdcard.img"

if [ ! -f "$img" ]; then
	echo "Missing image: $img" >&2
	exit 1
fi

case "$dev" in
	/dev/sd*|/dev/mmcblk*)
		;;
	*)
		echo "Refusing unusual block device path: $dev" >&2
		exit 1
		;;
esac

echo "About to overwrite $dev with $img"
echo "Press Ctrl-C within 5 seconds to abort."
sleep 5

sudo dd if="$img" of="$dev" bs=4M conv=fsync status=progress
sync

