# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

# load i3

i3conf=$HOME/.config/i3/i3.conf

if [ -f $i3conf ] ; then
    exec i3 -c $HOME/.config/i3/i3.conf
else
    echo i3 config file does not exist in $i3conf
fi
