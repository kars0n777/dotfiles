#  _____ _____ _____ 
# |___  |___  |___  |   karson777's zshrc file
#    / /   / /   / /    Only dependency is zsh-syntax-highlighting    
#   / /   / /   / /     This rc file is mean't for arch-based dis-
#  /_/   /_/   /_/      robutions.  
#

# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=5000000000
SAVEHIST=1000000000
unsetopt beep
# End of lines configured by zsh-newuser-install

### EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"

### "nvim" as manpager
#export MANPAGER="nvim -c 'set ft=man' -"

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
bindkey -v
export KEYTIMEOUT=1

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.style ':completion:*' menu select

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -lq\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
set_title () { print -rn $'\e]0;'${${:-${(%):-$1}$2}//[^[:print:]]/_}$'\a' }
precmd () { set_title '[%n@%M:%~]' '' }
preexec () { set_title '[%n@%M:%~]' " ($1)" }

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### ALIASES ###

# root privileges
alias doas="doas --"

# Colorize output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#alias cat='bat --theme=Dracula' 

# confirm before overwriting something
#alias cp="cp -i"
#alias mv='mv -i'
#alias rm='rm -i'

#ls
alias ls='exa --group-directories-first --icons -a'
alias lg='exa --group-directories-first --icons | grep'
alias ll='exa --group-directories-first --icons -la'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'

# youtube-dl
alias yta='youtube-dl -i '
alias yta-aac="youtube-dl -i --extract-audio --audio-format aac "
alias yta-best="youtube-dl -i --extract-audio --audio-format best "
alias yta-flac="youtube-dl -i --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl -i --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl -i --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl -i --extract-audio --audio-quality 0 --audio-format opus "
alias yta-vorbis="youtube-dl -i --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl -i --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -i -f bestvideo+bestaudio "
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

# Power
alias bye='shutdown now' 
alias reb='reboot'
alias hyb='systemctl hibernate'
alias hz='~/.75hz.sh'

# Shortened Programs
alias vim='nvim'
alias v='nvim'
alias r='ranger'
alias h='history 0'
alias hs='history 0 | grep '
alias b='bpytop'
alias e='exit'
alias show='mpv --no-resume-playback --shuffle ~/Videos/show-movie-autoplay'
alias sudoe='sudo -e' 
alias c='cmus'
alias z='zathura'
alias pcs='pokemon-colorscripts -r'
#alias lf='lfrun'
alias sxiv='sxiv -a' 
alias ani-cli='~/1tb-hdd/github/ani-cli/ani-cli'
alias ani='~/1tb-hdd/github/ani-cli/ani-cli'

# Directorys
alias dow='cd ~/downloads/'
alias doc='cd ~/documents/'
alias aud='cd ~/audio/'
alias mus='cd ~/audio/music/'
alias pic='cd ~/pictures/'
alias vid='cd ~/videos/'
alias con='cd ~/.config/'
alias 1='cd ~/1tb-hdd/'
alias sxiv='sxiv -a' 
alias pv='sudo protonvpn '
#alias moc='mocp'

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

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init zsh)"

### SYNTAX HIGHLIGHTING ###
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
