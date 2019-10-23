source $HOME/.commonprofile

# Get the aliases and functions
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

