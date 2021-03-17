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

export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*rc=:\ 
*.tar=:\
*.tgz=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.xz=:\
*.bz2=:\
*.bz=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.rar=:\
*.alz=:\
*.7z=:\
*.rz=:\
*.jpg=:\
*.JPG=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.gif=:\
*.bmp=:\
*.NEF=:\
*.ORF=:\
*.CR2=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.wmv=:\
*.avi=:\
*.flv=:\
*.3gp=:\
*.MTS=:\
*.aac= :\
*.flac= :\
*.m4a= :\
*.midi= :\
*.mp3= :\
*.ogg= :\
*.wav= :\
*.opus= :\
*.pdf=:\
*.nix=:\
*.xfc=:\ 
*.psd=:\
*.odt=:\  
*.doc=:\  
*.docx=:\  
"

# start WM in tty 1
if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep i3 || startx
fi
