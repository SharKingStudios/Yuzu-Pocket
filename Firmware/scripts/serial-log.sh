#!/usr/bin/env sh
set -eu

port="${1:-/dev/ttyUSB0}"
baud="${2:-115200}"

exec picocom -b "$baud" "$port"

