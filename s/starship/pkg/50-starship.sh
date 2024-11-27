##
## Initialises starship prompt for interactive shells
## Removing starship package will also remove this initialisation
##

# Check for interactive shell
[[ $- == *i* ]] || return 0

# Make sure TERM isn't 'linux' ..
case $TERM in
    linux) return 0;;
esac

# Initialise starship prompt

# For bash
[ -n "$BASH_VERSION" ]  && eval "$(starship init bash)"

# For zsh
[ -n "$ZSH_VERSION" ] && eval "$(starship init zsh)"
