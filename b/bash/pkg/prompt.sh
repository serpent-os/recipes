# Begin /usr/share/defaults/etc/profile.d/prompt.sh

e="\$"
if [ "$UID" = "0" ]; then
    e="#"
fi

PS1="\[\033[01;35m\]\u@\h\[\033[00m\] $e \[\033[01;34m\]\w\[\033[00m\] "
unset e

# End /usr/share/defaults/etc/profile.d/prompt.sh
