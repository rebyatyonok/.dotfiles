set -g -x PATH /usr/local/bin /usr/local/sbin $HOME/.cargo/bin $PATH

source ~/.config/fish/.iterm2_shell_integration.fish

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
