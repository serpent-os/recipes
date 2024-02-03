## recipes

This repository contains all of the recipes required to build Serpent OS
from source.

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

Individual software releases are available under the terms specified
upstream, collected in each `stone.yml` recipe. Any patches against
a software package is under the relevant license for each upstream.

Copyright © 2020-2024 Serpent OS Developers
