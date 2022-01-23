if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep dwm || startx "$HOME/.xinitrc"
fi
