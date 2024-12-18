#!/bin/bash

case $LD_PRELOAD in
    *libstdc++.so.6*)
        ;;
    "")
        export LD_PRELOAD="libstdc++.so.6"
        ;;
    *)
        export LD_PRELOAD="${LD_PRELOAD}:libstdc++.so.6"
        ;;
esac

exec /usr/lib/steam/steam "$@"
