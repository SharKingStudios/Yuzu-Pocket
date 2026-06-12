#!/usr/bin/env sh
set -eu

version="${BUILDROOT_VERSION:-2026.05}"
archive="buildroot-${version}.tar.xz"
url="https://buildroot.org/downloads/${archive}"

cd "$(dirname "$0")/.."

if [ -d buildroot ]; then
	echo "Firmware/buildroot already exists"
	exit 0
fi

mkdir -p dl

if [ ! -f "dl/${archive}" ]; then
	wget -O "dl/${archive}" "$url"
fi

tar -xf "dl/${archive}"
mv "buildroot-${version}" buildroot

echo "Fetched Buildroot ${version}"

