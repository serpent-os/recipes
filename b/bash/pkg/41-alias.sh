# Only continue if the shell is interactive
[ -t 0 ] || return 0

if [ -n "$BASH_VERSION" -o -n "$ZSH_VERSION" ] ; then    
    # non-shit default ls output when using POSIX compatible shells
    alias ls="ls --color=auto -F"
fi
