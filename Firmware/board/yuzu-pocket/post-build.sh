#!/usr/bin/env sh
set -eu

target_dir="$1"
help_dir="$target_dir/opt/yuzu-pocket/help"
help_img="$target_dir/opt/yuzu-pocket/help.img"

mkdir -p "$target_dir/boot/extlinux"
cat > "$target_dir/boot/extlinux/extlinux.conf" <<'EOF'
label Yuzu Pocket
  kernel /zImage
  devicetree /sun8i-v3lp-yuzu-pocket.dtb
  append console=ttyS0,115200 earlycon root=/dev/mmcblk0p2 rootwait rw panic=5
EOF

cp "$help_dir/HOW_TO_USE.txt" "$target_dir/boot/HOW_TO_USE.txt"
cp "$help_dir/YUZU_POCKET_TERMINAL.url" "$target_dir/boot/YUZU_POCKET_TERMINAL.url"

if [ -n "${HOST_DIR:-}" ] && [ -x "$HOST_DIR/sbin/mkfs.vfat" ] && [ -x "$HOST_DIR/bin/mcopy" ]; then
	rm -f "$help_img"
	dd if=/dev/zero of="$help_img" bs=1k count=768
	"$HOST_DIR/sbin/mkfs.vfat" -n YUZUPOCKET "$help_img"
	"$HOST_DIR/bin/mcopy" -i "$help_img" "$help_dir/HOW_TO_USE.txt" ::HOW_TO_USE.txt
	"$HOST_DIR/bin/mcopy" -i "$help_img" "$help_dir/YUZU_POCKET_TERMINAL.url" ::TERMINAL.url
	"$HOST_DIR/bin/mcopy" -i "$help_img" "$help_dir/YUZU_POCKET_TERMINAL.webloc" ::TERMINAL.webloc
else
	echo "warning: host mkfs.vfat/mcopy unavailable; USB help image not generated" >&2
fi

chmod 0755 \
	"$target_dir/etc/init.d/S20modules" \
	"$target_dir/etc/init.d/S30usb-gadget" \
	"$target_dir/etc/init.d/S40ttyd" \
	"$target_dir/usr/bin/led-test" \
	"$target_dir/usr/bin/spi-nor-info"
