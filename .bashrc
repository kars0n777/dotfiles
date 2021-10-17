#  _____ _____ _____ 
# |___  |___  |___  |   karson777's bashrc file
#    / /   / /   / /    This is based off of Distrotube's
#   / /   / /   / /     bashrc from https://gitlab.com/dwt1 
#  /_/   /_/   /_/      Just some changes for my personal use
#

# EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export ALTERNATE_EDITOR=""                        # setting for emacsclient
export EDITOR="nvim"          
export VISUAL="nvim"           
# SET MANPAGER
# Uncomment only one of these!

## "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
export MANPAGER="nvim -c 'set ft=man' -"

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PROMPT
# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '
PS2="> "
### Disable Ctrl S
stty -ixon

### Infinite bash history
HISTSIZE= HISTFILESIZE=

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### ALIASES ###

# root privileges
alias doas="doas --"

# Colorize output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#alias cat='bat -p --color'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#ls
alias ls='exa --group-directories-first'
alias sl='exa --group-directories-first'
alias la='exa --group-directories-first -a'
alias ll='exa --group-directories-first -l'
alias lal='exa --group-directories-first -la'
alias lla='exa --group-directories-first -la'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'

# youtube-dl
alias yta='youtube-dl '
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-quality 0 --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "
alias lr="~/./.likes-refresh.sh"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Default Manjaro Alias's
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# Package Managers 
alias sp='sudo pacman'
alias p='pacman'
alias a='paru'
alias y='yay'

# System
alias hz='~/.75hz.sh'

# Sxiv
alias sxiv='sxiv -a' 

# ProtonVPN
alias pv='sudo protonvpn '

# Power
alias bye='shutdown now' 
alias reb='reboot'
alias hyb='systemctl hibernate'

# Shortened Programs
alias vim='nvim'
# getting used to writing nvim just cuz ...
alias r='ranger'
alias h='history'
alias hs='history | grep'
alias b='bpytop'
alias e='exit'
alias iftop='sudo iftop -p'
alias show='mpv --no-resume-playback --shuffle ~/1.6TB\ HDD/Videos/Shows/'

# Directorys
alias dow='cd ~/Downloads/'
alias doc='cd ~/Documents/'
alias aud='cd ~/audio/'
alias pic='cd ~/Pictures/'
alias vid='cd ~/Videos/'
alias con='cd ~/.config/'
alias 1='cd ~/1.6TB\ HDD/'

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
#colorscript random

### PFETCH SYSTEM INFO ###
#pfetch

### NEOFETCH SYSTEM INFO ###
#fastfetch

### 777 COLORS ###
#lolcat -F .3 ~/.777

### COWFORTUNE ###
#fortune | cowsay | lolcat

### POKEMON COLORSCRIPTS ###
pokemon-colorscripts -r

### SOURCING BROOT ###
## source ~/.config/broot/launcher/bash/br

### BASH INSULTER ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"
