export PATH=$HOME/.config/scripts:$PATH
export TERMINAL="urxvt"
export EDITOR="emacsclient -t"
export BROWSER="palemoon"

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
