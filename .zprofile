export TERMINAL="termite"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="brave"
export READER="zathura"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export PATH=$HOME/.local/bin:$PATH

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
