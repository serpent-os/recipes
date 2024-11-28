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

# Initialise starship prompt with serpent's default prompt'
[ ! -d ~/.config ] && mkdir ~/.config
[ ! -e ~/.config/starship.toml ] && starship preset serpent-os -o  ~/.config/starship.toml

# For bash
[ -n "$BASH_VERSION" ]  && eval "$(starship init bash)"

# For zsh
[ -n "$ZSH_VERSION" ] && eval "$(starship init zsh)"
