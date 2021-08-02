# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

# startup programs

exec unclutter --timeout 1 --ignore-scrolling &   # hide mouse pointer
exec emacs --daemon &                             # everyone's favourite
which transmission-daemon >/dev/null && transmission-daemon  # torrenting
exec dunst &                                      # notifications
exec picom -b --experimental-backends &           # transparency
exec monitorstartup &                             # autoconfig connected monitors
exec sxhkd_run -t 10 -a "Escape" &		  # custom script to start sxhkd-statusd alongside sxhkd
exec mpd-monitor &				  # custom script, starts mpd and monitors it

exec wallset &

# load i3

i3conf=$HOME/.config/i3/i3.conf

if [[ "$(tty)" = "/dev/tty1" ]]; then
    if [ -f $i3conf ] ; then
	exec i3 -c $i3conf
    else
	echo i3 config file does not exist in $i3conf
    fi
elif [[ "$(tty)" = "/dev/tty2" ]]; then
    exec dwm
fi
