# Begin /usr/share/defaults/etc/profile.d/prompt.sh

# only set interactive prompt
[ -t 0 ] || return 0

if [ -n "$BASH_VERSION" ] ; then
    e="\$"
    if [ "$UID" = "0" ]; then
        # bold red
        e="\[\033[01;31m\]#\[\033[00m\]"
    fi

    PS1="\[\033[01m\]\u\[\033[00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[00m\]\n$e "
    unset e
# zsh has a very different PS1 format
elif [ -n "$ZSH_VERSION" ] ; then
    NEWLINE=$'\n'
    PS1="%B%n%b@%B%F{green}%m%f%b:%F{magenta}%~%f${NEWLINE}%# "
    unset NEWLINE
fi

# End /usr/share/defaults/etc/profile.d/prompt.sh
