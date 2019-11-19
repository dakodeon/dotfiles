export PATH=$HOME/.config/scripts:$PATH
export TERMINAL="urxvt"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
