# this should run on shell login
exec sudo rfkill unblock all &

# basic globals
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="emacs_ed"
export BROWSER="firefox"
export READER="zathura"
export FILEMAN="emacs_dired"
export GFILEMAN="thunar"
export MAILCLIENT="emacs_mail"

# specify XDG directory structure
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# change some locations to respect XDG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$XDG_CACHE_HOME/go"
export MU_HOME="$XDG_CACHE_HOME/mu"
export MAILDIR=".personal/Mail"
export WINEPREFIX="$XDG_DATA_HOME/wine"

# the path
export PATH=$PATH$( find $HOME/.local/bin/ -type d -printf ":%p" )

# misc options
export FZF_DEFAULT_COMMAND="find . -path \"*/.git\" -prune -o -printf \"%P\\n\""

# start WM in tty 1
if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
