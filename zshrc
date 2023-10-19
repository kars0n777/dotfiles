#  _____ _____ _____ 
# |___  |___  |___  |   karson777's zshrc file
#    / /   / /   / /    Based off of distrotube's zshrc. 
#   / /   / /   / /     Made for arch-based distrobutions
#  /_/   /_/   /_/      Dependencies: pokemon-colorscripts, 
#                       zsh-syntax-highlinting and others 
#                       are found in the alias's section.

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
export MANPAGER="/usr/bin/nvim -c 'Man!' -o -"
 
### "bat" as manpager
#export MANPAGER="sh -c 'col -bx | bat --theme Dracula -l man -p'"

### "vim" as manpager
#export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
#
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

# save path on cd
function cd {
    builtin cd $@
    pwd > ~/.last_dir
}

# restore last saved path
if [ -f ~/.last_dir ]
    then cd `cat ~/.last_dir`
fi

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lfrun -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^v' 'nvim\n'

bindkey -s '^g' 'gomuks\n'

bindkey -s '^n' 'ncmpcpp\n'

bindkey -s '^a' 'clear;qalc\n'

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

# Colorize output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#ls
alias ls='exa --group-directories-first --icons'
alias lsa='exa --group-directories-first --icons -a'
alias l='exa --group-directories-first --icons -l'
alias la='exa --group-directories-first --icons -la'
alias lg='exa --group-directories-first --icons -l | grep --color=auto'
alias ".."='cd ..'
alias mkdir='mkdir -pv'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# yt-dlp
alias yt='yt-dlp -i '
alias ytflac="yt-dlp -i --extract-audio --audio-format flac "
alias ytopus="yt-dlp -i --extract-audio --audio-quality 0 --audio-format opus "
alias ytplay="yt-dlp -i --extract-audio --audio-quality 0 --audio-format opus -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "
alias ytbest="yt-dlp -i -f bestvideo+bestaudio "

# Package Managers 
alias sp='sudo pacman'
alias p='pacman'
alias sa='sudo apt'
alias a='apt'
alias pa='paru'
alias sf='sudo flatpak'
alias fl='flatpak'
alias sn='sudo pacman --noconfirm'
alias an='paru --noconfirm'

# General Aliases 
alias v='nvim'
alias vw='nvim ~/documents/vimwiki/index.md'
alias vim='nvim'
alias h='history 0'
alias hs='history 0 | grep '
alias se='sudoedit'
alias e='exit'
alias z='zathura'
alias pc='pokemon-colorscripts -r'
alias lf='lfcd'
alias sxiv='nsxiv -r -a' 
alias pm='pulsemixer'
alias mac='sudo macchanger eth0 --random'
alias b='btop'
alias ra='radeontop -c -T'
alias t='wtwitch w'
alias wt='wtwitch c'
alias n='ncmpcpp'
alias g='gomuks'
alias neofetch='clear;neofetch --ascii ~/.config/neofetch/artix-small.txt'
alias r='~/scripts/newsboat-cache.sh'
alias rss='newsboat'
alias th='st & disown' # quickly opening a terminal in same directory
alias lynx='lynx -accept_all_cookies https://lite.duckduckgo.com'
alias '?'='w3m-duckduckgo.sh' # found in ~/scripts/w3m
alias '??'='w3m-wiby.sh' # found in ~/scripts/w3m
alias '???'='w3m-google.sh' # found in ~/scripts/w3m
alias bat='bat --theme Dracula'
alias y='ytfzf -t --ii=inv.vern.cc'
alias k='kjv'
alias x='nsxiv -rab'
alias s='sncli'

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
alias po='sudo poweroff'
alias re='sudo reboot'
alias hi='loginctl hibernate'

### RANDOM COLOR SCRIPT ###
#colorscript -r

### NEOFETCH SYSTEM INFO ###
#neofetch 

### COWFORTUNE ###
#fortune | cowsay 

### POKEMON COLORSCRIPTS ###
pokemon-colorscripts -r

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init zsh)"

### ZSH AUTOCOMPLETEION (like in fish) ###
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

### SYNTAX HIGHLIGHTING ###
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
