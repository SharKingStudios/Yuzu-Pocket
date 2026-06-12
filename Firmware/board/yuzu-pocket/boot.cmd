setenv bootargs console=ttyS0,115200 earlycon root=/dev/mmcblk0p2 rootwait rw panic=5
load mmc 0:1 ${kernel_addr_r} zImage
load mmc 0:1 ${fdt_addr_r} sun8i-v3lp-yuzu-pocket.dtb
bootz ${kernel_addr_r} - ${fdt_addr_r}

