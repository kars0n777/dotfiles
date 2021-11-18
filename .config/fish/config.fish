#
#  _____ _____ _____    karson777's fish config file
# |___  |___  |___  |   Based off of distrotube's config.fish 
#    / /   / /   / /    Made for arch-based distrobutions 
#   / /   / /   / /     Dependencies: pokemon-colorscripts,    
#  /_/   /_/   /_/      starship and others are found in the alias's section.  
#                       
#



### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "nvim"                                 # $EDITOR use Neovim in terminal
set VISUAL "nvim"                                 # $VISUAL use Neovim in GUI mode

set fish_vi_force_cursor                          # VI mode aware cursor type  
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block



### THEME ###
# Dracula Color Palette
set -l foreground f8f8f2
set -l selection 44475a
set -l comment 6272a4
set -l red ff5555
set -l orange ffb86c
set -l yellow f1fa8c
set -l green 50fa7b
set -l purple bd93f9
set -l cyan 8be9fd
set -l pink ff79c6

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment



### FUNCTIONS ###

# VI mode
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end



### KEYBINDINGS ####
#nothing lol



### ALIASES ###

# Colorize output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#ls
alias ls='exa --group-directories-first --icons -a'
alias ll='exa --group-directories-first --icons -la'
alias lg='exa --group-directories-first --icons | grep'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias vifm='./.config/vifm/scripts/vifmrun'

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

# Package Managers 
alias sp='sudo pacman'
alias p='pacman'
alias a='paru'

# Power
alias shu='sudo openrc-shutdown -p now' 
alias reb='sudo reboot'

# Scripts
alias mac='~/scripts/ip-mac-change.sh'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias lr="~/./.likes-refresh.sh"
alias hz='~/scripts/75hz.sh'

# Shortened Programs
alias v='nvim'
alias h='history'
alias hs='history | grep '
alias b='bpytop'
alias e='exit'
alias sudoe='sudo -e' 
alias z='zathura'
alias pcs='pokemon-colorscripts -r'
alias lf='lf'
alias sxiv='nsxiv -r -a' 
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



### NEW SHELL SCRIPT ###
# DT's Random colorscript 
#colorscript random

# pfetch minimal system info
#pfetch

# cowfortune quotes from terminal
#fortune | cowsay 

# pokemon random colorscript
pokemon-colorscripts -r



### PROMPT ###
# starship prompt 
starship init fish | source
