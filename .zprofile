# this should run on shell login
exec sudo rfkill unblock all &

# default applications
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export READER="zathura"
export FILEMAN="lf-ueberzug"
export GFILEMAN="pcmanfm"
export IMGVIEWER="nsxiv"
export MAILCLIENT="emacs_mail"

# XDG directory structure
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# change some locations to respect XDG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$XDG_CACHE_HOME/go"
export CARGOHOME="$XDG_DATA_HOME/cargo"
export MU_HOME="$XDG_CACHE_HOME/mu"
export MAILDIR="$XDG_DATA_HOME/mail"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsyncrc"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CALCHISTFILE="$XDG_STATE_HOME/calc_history"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export MEDNAFEN_HOME="$XDG_DATA_HOME/mednafen"

# shell history
export HISTFILE="$XDG_STATE_HOME/shell/history"
export HISTSIZE=10000
export SAVEHIST=10000

# the path
export PATH=$PATH$( find $HOME/.local/bin/ -type d -printf ":%p" )

# globals for programs
export FZF_DEFAULT_COMMAND="find . -path \"*/.git\" -prune -o -printf \"%P\\n\""
export MPC_FORMAT="[[%composer% (&%artist%)]|%artist%] - %title%"

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
*.aac=:\
*.flac=:\
*.m4a=:\
*.midi=:\
*.mp3=:\
*.ogg=:\
*.wav=:\
*.opus=:\
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
