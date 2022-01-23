#  _____ _____ _____ 
# |___  |___  |___  |   karson777's bashrc file
#    / /   / /   / /    This is based off of Distrotube's
#   / /   / /   / /     bashrc from https://gitlab.com/dwt1 
#  /_/   /_/   /_/      Just some changes for my personal use
#

# Note: I don't use bash anymore if you want my updated alias's
# or shell configurations use zsh :) or use whatver idc lol 

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

# Colorize output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias cr='cp -r'
alias mv='mv -i'
alias rm='rm -i'
alias rf='rm -rf'

#ls
alias ls='exa --group-directories-first --icons'
alias lsa='exa --group-directories-first --icons -a'
alias l='exa --group-directories-first --icons -l'
alias la='exa --group-directories-first --icons -la'
alias lg='exa --group-directories-first --icons -l | grep --color=auto'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
#alias vifm='./.config/vifm/scripts/vifmrun'

# yt-dlp
alias yta='yt-dlp -i '
alias yta-flac="yt-dlp -i --extract-audio --audio-format flac "
alias yta-opus="yt-dlp -i --extract-audio --audio-quality 0 --audio-format opus "
alias ytv-best="yt-dlp -i -f bestvideo+bestaudio "

# Package Managers 
alias sp='sudo pacman'
alias p='pacman'
alias a='paru'
alias sf='sudo flatpak'
alias fl='flatpak'
alias spn='sudo pacman --noconfirm'
alias an='paru --noconfirm'

# Shortened Programs
alias v='nvim'
alias vim='nvim'
alias h='history 0'
alias hs='history 0 | grep '
alias se='sudoedit'
alias su='sudo su'
alias e='exit'
alias za='zathura'
alias pc='pokemon-colorscripts -r'
alias lf='lfcd'
alias sxiv='nsxiv -r -a' 
alias s='nsxiv -r -a' 
alias n='neofetch'
alias m='mpv'
alias pm='pulsemixer'
alias h='htop'
alias sma='sudo make install'
alias lb='librewolf -p main-privacy'  
alias mac='sudo macchanger enp4s0 --random'

# Git
alias ga='git add .'
alias gco='git commit -m'                                   # make sure you add a commit message in " " 
alias gp='git push'
alias p2g='git add . && git commit -m "lol" && git push'    # push to git

# Shell
alias b='bash'
alias f='fish'
alias z='zsh'

# Directorys
alias c='cd'
alias dow='cd ~/downloads/'
alias doc='cd ~/documents/'
alias aud='cd ~/audio/'
alias mus='cd ~/audio/music/'
alias pic='cd ~/pictures/'
alias vid='cd ~/videos/'
alias con='cd ~/.config/'

# Power
alias po='poweroff'
alias re='reboot'
alias hi='systemctl hibernate'

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
