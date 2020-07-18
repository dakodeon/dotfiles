## Options section

# setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
eval "$(dircolors -b)"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/cache
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zmodload zsh/complist

HISTFILE=$XDG_CACHE_HOME/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

## Keybindings section
# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

# edit lines in vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# how to make this work
# bindkey -M vicmd 'ZZ' exit

# these don't work?
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey "^?" backward-delete-char

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		 [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
			 [[ ${KEYMAP} == viins ]] ||
			 [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}

zle -N zle-keymap-select
zle-line-init() {
	zle -K viins
	echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # vi mode starts in insert, the cursor should reflect this
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# these were already here
# bindkey -e
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

# Print a greeting message when shell is started
# cat ~/Documents/ascii/$(ls ~/Documents/ascii | sort -R | head -1)
echo -e "\n\033[32;1m➛ \033[34;3m"$USER@$HOST"\033[32m ➛ \033[34;3m"$(lsb_release -ds | tr -d '"')"\033[32;1m ➛ \033[34;3m"$(uname -r)" \033[32;1m➛\n"

# enable substitution for prompt
setopt prompt_subst

# prompt message
PROMPT="%B%{$fg[green]%}%1~%(?.%{$fg[green]%}.%{$fg[red]%}) 〉%{$reset_color%}%b" # Print some system information when the shell is first started

### Git prompt functions

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
  # Show Git branch/tag, or name-rev if on detached head
  ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
  # Show different symbols as appropriate for various Git repository states
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

git_prompt_string() {
  local git_where="$(parse_git_branch)"
  
  # If inside a Git repository, print its branch and state
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
  
  # If not inside the Git repo, print exit codes of last command (only if it failed)
  [ ! -n "$git_where" ] && echo "%{$fg[red]%} %(?..[%?])"
}

## Prompt on right side:
#  - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
#  - shows exit status of previous command (if previous command finished with an error)
#  - is invisible, if neither is the case

# Right prompt with exit status of previous command if not successful
#RPROMPT="%{$fg[red]%} %(?..[%?])" 
# Right prompt with exit status of previous command marked with ✓ or ✗
# RPROMPT="%(?.%{$fg[green]%}✓ %{$reset_color%}.%{$fg[red]%}✗ %{$reset_color%})"

RPROMPT="%{$fg[red]%} %(?..[%?])"
RPROMPT='$(git_prompt_string)'

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r
export LESS=-r

# functions to change window name -- these work with st, however the $TERM
# variable should be "xterm*". This is not the case with st
chpwd () {print -Pn "\e]0;$TERMINAL - %~\a"}
# I don't prefer the method below as it occasionally prints weird names
# preexec () {print -PDn "\e]0;$TERMINAL - $2\a"}
# function to dynamically change the name of the terminal

# custom function to change window name
chname() {
	printf "\033]2;$TERMINAL - $1\007"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## Alias section 

# add sensible options
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

# exit
alias q='exit'

# aliases for programs
# note the use of chname for terminal apps. caveat: the name remains after
# exiting (run chname again if desired)
alias e='emacsclient -c '
alias et='chname emacs; emacsclient -t '
alias er='pgrep emacs >/dev/null && pkill emacs; emacs --daemon'
alias v='chname nvim; nvim '
alias nb='chname newsboat; newsboat'
alias ra='chname ranger; ranger '
alias lf='chname lf; lf '
alias z='zathura '

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
alias R='cd /Music/Ρεμπέτικα; pwd'
alias V='cd $HOME/Videos; pwd'
alias m='cd /media; pwd'
alias p='cd $HOME/.personal; pwd'
alias R='cd $HOME/.source; pwd'
alias Rd='cd $HOME/.source/dotfiles; pwd'
alias E='cd $HOME/.emacs.d; pwd'
alias C='cd $HOME/.config; pwd'
alias S='cd $HOME/.local/bin; pwd'

# aliases for conf files
alias cni='$EDITOR $HOME/.config/i3/i3.conf'
alias cnr='$EDITOR $HOME/.config/ranger/rc.conf'
alias cnz='$EDITOR $ZDOTDIR/.zshrc'
alias cnx='$EDITOR $HOME/.Xresources'
alias cne='$EDITOR $HOME/.emacs.d/my-config.org'
alias cnf='$EDITOR "/sudo:root@dubajamaman:/etc/fstab"'

# aliases for my scripts
alias es='scriptsel -t'
alias esn='newscript '
alias ec='configsel -t'
alias ecn='dotfiles-update '
alias sx='sxivdir'

# copy file contents to clipboard
alias yX='xclip -sel c < '

# for emacs-vterm -- not exactly sure what this does, though
function vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
   alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi
