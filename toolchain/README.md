## toolchain

Managed toolchain recipes for Serpent OS.

Note that Serpent OS uses LLVM/Clang toolchain with `libc++` / `libc++abi`
by default. We are gradually weeding out `libgcc_s.so.1` but packages can
optionally be built with the GNU toolchain:

```yaml
# stone.yml
toolchain: gnu
```

### License

Unless otherwise specified, all packaging recipes are available under
the terms of the [Zlib](https://spdx.org/licenses/Zlib.html) license.

Individual software releases are available under the terms specified
upstream, collected in each `stone.yml` recipe. Any patches against
a software package is under the relevant license for each upstream.

Copyright © 2020-2023 Serpent OS Developers