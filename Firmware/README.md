# Yuzu Pocket Firmware

Minimal Linux firmware for the Yuzu Pocket Allwinner V3LP board.

This directory is a Buildroot br2-external tree. It keeps Yuzu Pocket board support in this repo while using a clean upstream Buildroot checkout in `Firmware/buildroot/`.

## Target Image

- U-Boot SPL + U-Boot for the V3s-like sunxi boot path.
- UART0 console on PB8/PB9 at 115200 8N1.
- microSD boot on SDC0/PF0-PF5.
- 64 MB RAM.
- BusyBox rootfs.
- SPI NOR support for W25Q256 JEDEC/MTD detection.
- 14 GPIO LEDs, PE0-PE13, active high through ULN2003 inputs.
- USB gadget setup for ACM serial, ECM network, and a read-only help volume.
- Browser terminal through ttyd at `http://loganpeterson.local:7681/`.
- DHCP/DNS fallback at `http://10.0.0.1:7681/`.

## Quick Start

Run from a Linux or WSL shell with normal Buildroot dependencies installed:

```sh
cd Firmware
sh scripts/fetch-buildroot.sh
sh scripts/build.sh
```

The expected final image is:

```text
Firmware/output/yuzu_pocket/images/sdcard.img
```

## User-Facing Plug-In Flow

When the board boots over USB, it should expose:

- a small read-only help drive with `HOW_TO_USE.txt` and terminal shortcut files,
- a USB network at `10.0.0.1`,
- mDNS name `loganpeterson.local`,
- a ttyd web shell on port `7681`.

The files shown to a user are kept in:

```text
board/yuzu-pocket/rootfs_overlay/opt/yuzu-pocket/help/
```

## Source Baseline

- Buildroot: `2026.05`
- Linux: `6.12.93` longterm
- U-Boot: Buildroot-managed custom version `2026.04`
- Closest upstream board model: Allwinner V3s / Lichee Pi Zero

The V3LP-specific assumption is concentrated in the board DTS and U-Boot config fragment. If SPL DRAM init needs vendor V3LP parameters, those belong in `board/yuzu-pocket/uboot/`.
