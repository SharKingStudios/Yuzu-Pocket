# bareiron Integration Point

Upstream bareiron is small enough to be plausible on Yuzu Pocket, especially with 64 MB RAM. It is not enabled in the default firmware image yet because the upstream build requires a generated `include/registries.h` file before compilation.

Upstream notes checked:

- Project: https://github.com/p2r3/bareiron
- Language: mostly C.
- Build command: `gcc src/*.c -O2 -Iinclude -o bareiron`
- Current Minecraft target: 1.21.8 / protocol 772.
- Required pre-build asset: generated Minecraft registry data from a vanilla server JAR.

Once `registries.h` is generated, put it here:

```text
Firmware/board/yuzu-pocket/bareiron/registries.h
```

Then the next firmware step is to add a small Buildroot package that:

1. Fetches `p2r3/bareiron`.
2. Copies this generated `registries.h` into `include/`.
3. Compiles with the target C compiler.
4. Installs `/usr/bin/bareiron`.
5. Adds an init script for TCP port `25565`.

This is intentionally not hard-enabled yet because a missing generated registry header would break the main firmware build.

