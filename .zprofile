export TERMINAL="urxvt"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"
export MEDNAFEN_HOME="$XDG_CONFIG_HOME/mednafen"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export PATH=$HOME/.local/bin:$PATH

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
