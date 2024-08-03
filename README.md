## recipes

This repository contains all of the recipes required to build Serpent OS
from source.

## Quick start for boulder (Serpent OS native)

Obviously, if your name isn't Ikey, then use your own `$USERNAME`

### /etc/subuid (`userns`)

    ikey:100000:65536

### /etc/subgid (`userns`)

    ikey:100000:65536

### Local repository

Our `justfile` defaults to `local-x86_64` profile with boulder. While we traditionally shipped this pre-enabled configuration, we figured that mandating
`root`-user and world-accessible directories was generally a Bad Move.

**Create an empty local repository**

```bash
$ mkdir ~/.local_repo && cd ~/.local_repo
$ moss index .
```

**Create a profile**

We'll add the (unversioned) volatile repository at the bottom layer, and elevate
our local repository priority to take precedence.

```bash
$ boulder profile add local-x86_64 --repo name=volatile,uri=https://dev.serpentos.com/volatile/x86_64/stone.index,priority=0 --repo name=local,uri=file:///$HOME/.local_repo/stone.index,priority=10
```

### Go go go

Well, actually Rust.. Anyway, quickly try to build `m/m4/stone.yaml` or `n/nano/stone.yaml` for a quick and easy confirmation that everything works OK.

## Git summary requirements

To keep git summaries readable, serpent-os requires the following git summary format

- `name: Add at v<version>`
- `name: Update to v<version>`
- `name: Fix <...>`
- `name: [NFC] <description of no functional change>`

The use of the `Initial inclusion` verbiage is _strongly discouraged_.

## Current focus

Packaging focus should be on bringing up the GNOME Desktop + associated stack

Other areas of focus:

 - Stateless enabling (+ hermetic usr)
 - Kernel enabling
 - Metrics-based performance improvements
 - Package updates and bug fixes

The aim for our desktop right now is to ship the following:

 - GNOME Shell
 - Flatpak w/ preconfigured flathub
 - GNOME Software (pending moss integration)
 - GNOME Console or Terminal
 - Nautilus
 - GNOME Control Center
 - Firefox
 - Thunderbird

### License

Unless otherwise specified, all packaging recipes are available under
the terms of the [MPL-2.0](https://spdx.org/licenses/MPL-2.0.html) license.

The Serpent OS Developers reserve the right to reject recipe contributions
which are not licensed to the Serpent OS Developer collective under the MPL-2.0 license

Individual software releases are available under the terms specified
upstream, collected in each `stone.yaml` recipe. Any patches against
a software package is under the relevant license for each upstream.

Copyright © 2020-2024 Serpent OS Developers
