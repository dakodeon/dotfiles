export PATH=$HOME/.config/scripts:$PATH
export TERMINAL="urxvt"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"
export MEDNAFEN_HOME="$XDG_CONFIG_HOME/mednafen"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
