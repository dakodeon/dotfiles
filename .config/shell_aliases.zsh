### Shell aliases -- separate file to be loaded in multiple shells

alias q='exit'

# some sensible options for commands
alias cp="cp -iv"     # Confirm before overwriting something
alias mv="mv -iv"
alias rm="rm -vI"
alias df='df -h'      # Human-readable sizes
alias du='du -h'
alias free='free -m'  # Show sizes in MB

# aliases for ls 
alias ll='ls -l'
alias la='ls -al'
alias l.='ls -d .*'

# aliases for programs
# note the use of chname for terminal apps. caveat: the name remains after
# exiting (run chname again if desired)
alias e='devour emacsclient -c '
alias et='chname emacsterm; emacsclient -t '
alias er='pgrep emacs >/dev/null && pkill emacs; emacs --daemon'
alias v='chname nvim; nvim '
alias nb='chname newsboat; newsboat'
alias ra='chname ranger; ranger '
# alias lf='chname lf; lf '
alias lf="lf-ueberzug"
alias z='devour zathura '
alias vr='vimv '
alias mp='devour mpv'

alias c='highlight -J 120 -V -O ansi'
# aliases for git

alias g.='git status'
alias gd='git diff '
alias gC='git clone '
alias ga='git add'
alias gc='git commit -m '
alias gA='git add . && git commit -m '
alias gp='git push'
alias gO='git remote set-url origin git@github.com:'
alias gu='git restore '
alias gU='git restore .'
alias gr='git restore --staged '
alias g\?='alias | grep git'

# aliases for pacman

alias pS='sudo pacman -S ' # install
alias pU='sudo pacman -Syu ' # upgrade
alias pf='pacman -Ss ' # find package
alias pR='sudo pacman -Rns ' # remove
alias pl='pacman -Qe' # list expl. installed packages
alias plu='pacman -Qdt' # list unneeded packages installed as deps
alias pi='pacman -Qi ' # info about installed package
alias pis='pacman -Si ' # info about package
alias pif='pacman -Ql ' # files of installed package
alias pifs='pacman -Sl ' # files of package
alias pC='sudo pacman -Sc' # clear database of uninstalled packages
alias pCC='sudo pacman -Scc' # clear database of all packages
alias p\?='alias | grep pacman'

# aliases for directories
alias h='cd; pwd'
alias D='cd $HOME/Downloads; pwd'
alias d='cd $HOME/Documents; pwd'
alias M='cd $HOME/Music; pwd'
alias P='cd $HOME/Pictures; pwd'
alias R='cd $HOME/Music/Ρεμπέτικα; pwd'
alias V='cd $HOME/Videos; pwd'
alias m='cd /media; pwd'
alias p='cd $HOME/.personal; pwd'
alias r='cd $HOME/.source; pwd'
alias rd='cd $HOME/.source/dotfiles; pwd'
alias E='cd $HOME/.emacs.d; pwd'
alias C='cd $HOME/.config; pwd'
alias S='cd $HOME/.local/bin; pwd'
alias w='cd /var/www/lukesrv; pwd'
alias d\?='alias | grep cd'

# aliases for my scripts
alias es='scriptsel -t'
alias esn='newscript '
alias ec='configsel -t'
alias ecn='dotfiles-update '
alias sx='sxivdir'

# misc aliases
# rsync my website!
alias WS='rsync -rptzP --exclude "photoshow/photofull.html" --exclude "photoshow/diffs" /var/www/lukesrv/* root@lukebass.xyz:/var/www/lukesrv/'

# copy file contents to clipboard
alias yX='xclip -sel c < '
