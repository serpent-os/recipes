#!/usr/bin/sh
#
# Begin /usr/share/defaults/etc/serpent-stateless-shell-conf.sh

# The idea is that all shells are patched to have their startup
# scripts look inside /usr/share/defaults/etc/ for their preferred
# system-level default initialization files.

# For bash, this implies a fan-in configuation where both
# /usr/share/defaults/etc/profile and /usr/share/defaults/etc/bashrc
# source the present file, so as to ensure that there is no difference
# in the experience whether a user logs in via getty, via sshd or opens
# a new virtual terminal in a desktop environment.
#
# This should make testing configuration changes more straightforward.

# Files in the below dir MUST be in portable .sh format!
if [ -d /usr/share/defaults/etc/profile.d ] ; then
    for script in /usr/share/defaults/etc/profile.d/*.sh
    do
      source $script
    done
    unset script
fi

# Files in the below dir MUST be in portable .sh format!
if [ -d /etc/profile.d ] ; then
    for script in /etc/profile.d/*.sh
    do
      source $script
    done
    unset script
fi

# Contents of the below file MUST be in portable .sh format!
if [ -f /etc/profile ] ; then
    source /etc/profile
fi

# IFF shell is bash, source relevant bash config files
#
# Everything sourced inside this conditional block may optionally use
# bash syntax, given we only execute it with bash.
#
if [ "$(/usr/bin/readlink /proc/$$/exe)" = "/usr/bin/bash" ] ; then

    if [ -e /etc/bashrc ] ; then
        source /etc/bashrc
    fi

    # We want to source all files ending in sh, like *.sh or *.bash
    #
    # This enables users to add e.g. a `.disabled` extension to scripts
    # (or remove `sh` extensions from scripts or links to scripts) to disable
    # them temporarily, which can be handy when troubleshooting.
    #
    if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*sh; do
            if [ -f "$rc" ]; then
                source "$rc"
            fi
        done
        unset rc
    fi

    alias ls="ls --color=auto -F"
fi 
# End /usr/share/defaults/etc/serpent-stateless-shell-conf.sh
