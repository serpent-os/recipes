# Begin /usr/share/defaults/etc/bashrc

alias ls="ls --color=auto -F"

e="\$"
if [ "$UID" = "0" ]; then
    e="#"
fi

PS1="\[\033[01;35m\]\u@\h\[\033[00m\] $e \[\033[01;34m\]\w\[\033[00m\] "
unset e

if [ -e /usr/share/defaults/etc/profile ] ; then
    source /usr/share/defaults/etc/profile
fi

if [ -e /etc/bashrc ] ; then
    source /etc/bashrc
fi

# End /usr/share/defaults/etc/bash.bashrc
