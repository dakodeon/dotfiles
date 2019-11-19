# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

# startup programs

exec sxhkd -c $HOME/.config/sxhkdrc &             # keybindings
exec unclutter --timeout 1 --ignore-scrolling &   # hide mouse pointer
exec emacs --daemon &                             # everyone's favourite
exec transmission-daemon &                        # torrenting
exec udiskie -s &                                 # bloated drive management
exec dunst &                                      # notifications
exec compton -b &                                 # transparency
exec conky -c $HOME/.config/conky.conf &          # desktop ricing
exec monitorstartup &                             # autoconfig connected monitors

# load i3

i3conf=$HOME/.config/i3/i3.conf

if [ -f $i3conf ] ; then
    exec i3 -c $i3conf
else
    echo i3 config file does not exist in $i3conf
fi
