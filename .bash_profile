source $HOME/.commonprofile

# Get the aliases and functions
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. "$HOME/.cargo/env"
