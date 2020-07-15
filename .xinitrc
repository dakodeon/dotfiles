# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

# startup programs

exec unclutter --timeout 1 --ignore-scrolling &   # hide mouse pointer
exec emacs --daemon &                             # everyone's favourite
exec transmission-daemon &                        # torrenting
exec dunst &                                      # notifications
exec picom -b &                                   # transparency
# exec conky -c $HOME/.config/conky.conf &          # desktop ricing
exec monitorstartup &                             # autoconfig connected monitors

exec wallset &

# load i3

i3conf=$HOME/.config/i3/i3.conf

if [[ "$(tty)" = "/dev/tty1" ]]; then
    if [ -f $i3conf ] ; then
	exec sxhkd -c $HOME/.config/sxhkdrc & # this is specific to i3
	exec i3 -c $i3conf
    else
	echo i3 config file does not exist in $i3conf
    fi
elif [[ "$(tty)" = "/dev/tty2" ]]; then
    exec bspwm
fi
