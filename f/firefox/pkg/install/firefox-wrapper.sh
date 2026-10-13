#!/usr/bin/bash

##
## Variables
##
MOZ_FIREFOX_FILE="firefox"
MOZ_LIB_DIR="/usr/lib"
MOZ_DIST_BIN="$MOZ_LIB_DIR/firefox"
MOZ_LANGPACKS_DIR="$MOZ_DIST_BIN/langpacks"
MOZ_EXTENSIONS_PROFILE_DIR="$HOME/.mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
MOZ_PROGRAM="$MOZ_DIST_BIN/$MOZ_FIREFOX_FILE"

if [ ! -r "$MOZ_PROGRAM" ]; then
    echo "Error: $MOZ_PROGRAM not found"
    exit 1
fi

##
## Use D-Bus remote exclusively when there's Wayland display.
##
if [ "$WAYLAND_DISPLAY" ]; then
  export MOZ_DBUS_REMOTE=1
fi

##
## Set MOZILLA_FIVE_HOME
##
export MOZILLA_FIVE_HOME="$MOZ_DIST_BIN"

##
## Set MOZ_APP_LAUNCHER for gnome-session
##
export MOZ_APP_LAUNCHER="/usr/bin/firefox"

##
## Automatically installed langpacks are tracked by .aerynos-langpack-install
## config file.
##
AERYNOS_LANGPACK_CONFIG="$MOZ_EXTENSIONS_PROFILE_DIR/.aerynos-langpack-install"

# MOZ_DISABLE_LANGPACKS disables language packs completely
MOZILLA_DOWN=0
if ! [ $MOZ_DISABLE_LANGPACKS ] || [ $MOZ_DISABLE_LANGPACKS -eq 0 ]; then
    if [ -x $MOZ_PROGRAM ]; then
        # Is firefox running?
        /usr/bin/pidof $MOZ_PROGRAM > /dev/null 2>&1
        MOZILLA_DOWN=$?
    fi
fi

# Modify language pack configuration only when firefox is not running
# and language packs are not disabled
if [ $MOZILLA_DOWN -ne 0 ]; then

    # Clear already installed langpacks
    mkdir -p $MOZ_EXTENSIONS_PROFILE_DIR
    if [ -f $AERYNOS_LANGPACK_CONFIG ]; then
        rm `cat $AERYNOS_LANGPACK_CONFIG` > /dev/null 2>&1
        rm $AERYNOS_LANGPACK_CONFIG > /dev/null 2>&1
        # remove all empty langpacks dirs while they block installation of langpacks
        rmdir $MOZ_EXTENSIONS_PROFILE_DIR/langpack* > /dev/null 2>&1
    fi

    # Get locale from system
    CURRENT_LOCALE=$LC_ALL
    CURRENT_LOCALE=${CURRENT_LOCALE:-$LC_MESSAGES}
    CURRENT_LOCALE=${CURRENT_LOCALE:-$LANG}

    # Try with a local variant first, then without a local variant
    SHORTMOZLOCALE=`echo $CURRENT_LOCALE | sed "s|_\([^.]*\).*||g" | sed "s|\..*||g"`
    MOZLOCALE=`echo $CURRENT_LOCALE | sed "s|_\([^.]*\).*|-\1|g" | sed "s|\..*||g"`

    function create_langpack_link() {
        local language=$*
        local langpack=langpack-${language}@firefox.mozilla.org.xpi
        if [ -f $MOZ_LANGPACKS_DIR/$langpack ]; then
            rm -rf $MOZ_EXTENSIONS_PROFILE_DIR/$langpack
            # If the target file is a symlink (the fallback langpack),
            # install the original file instead of the fallback one
            if [ -h $MOZ_LANGPACKS_DIR/$langpack ]; then
                langpack=`readlink $MOZ_LANGPACKS_DIR/$langpack`
            fi
            ln -s $MOZ_LANGPACKS_DIR/$langpack \
                  $MOZ_EXTENSIONS_PROFILE_DIR/$langpack
            echo $MOZ_EXTENSIONS_PROFILE_DIR/$langpack > $AERYNOS_LANGPACK_CONFIG
            return 0
        fi
        return 1
    }

    create_langpack_link $MOZLOCALE || create_langpack_link $SHORTMOZLOCALE || true
fi

# FIREFOX_APP_REMOTINGNAME links Firefox with desktop file name
if [ -z "$FIREFOX_APP_REMOTINGNAME" ]
then
  export FIREFOX_APP_REMOTINGNAME=org.mozilla.firefox
fi

# FIREFOX_DBUS_APP_NAME sets app name for DBus services like Gnome Shell
# search provider or remote launcher
# DBus interface name (or prefix) is org.mozilla.FIREFOX_DBUS_APP_NAME
if [ -z "$FIREFOX_DBUS_APP_NAME" ]
then
  export FIREFOX_DBUS_APP_NAME=firefox
fi

# Don't throw "old profile" dialog box.
export MOZ_ALLOW_DOWNGRADE=1

# Run the browser
exec $MOZ_PROGRAM "$@"
