#!/bin/bash

if [[ ! -z "${SERPENT_STEAM_SHIM}" ]]; then
    exec /usr/lib/steam/bin_steam.sh "$@"
fi

export SERPENT_STEAM_SHIM=1
if [[ ! -z "${LD_PRELOAD}" ]]; then
    export LD_PRELOAD="${LD_PRELOAD}:libstdc++.so.6"
else
    export LD_PRELOAD="libstdc++.so.6"
fi

exec /usr/lib/steam/bin_steam.sh "$@"
