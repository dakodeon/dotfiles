# basic globals
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"
export READER="zathura"

# specify XDG directory structure
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# change some locations to respect XDG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$XDG_CACHE_HOME/go"
export MU_HOME="$XDG_CACHE_HOME/mu"
export WINEPREFIX="$XDG_DATA_HOME/wine"

# misc options
export FZF_DEFAULT_COMMAND="find . -path \"*/.git\" -prune -o -printf \"%P\\n\""

# the path
export PATH=$HOME/.local/bin/statusbar/dwm/:$HOME/.local/bin/statusbar/:$HOME/.local/bin/:$PATH

# start WM in tty 1
if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
