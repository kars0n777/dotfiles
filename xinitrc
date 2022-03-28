### karson777's xinitrc ###
#   github.com/kars0n777

### Export ###
export PATH="${PATH}:${HOME}/scripts" 
## qt5ct as qtthememanager 
export QT_QPA_PLATFORMTHEME=qt5ct
#unset QT_STYLE_OVERRIDE # kvantum as qtthememanager
export QT_STYLE_OVERRIDE=kvantum

### Appearence ### 
#nitrogen --restore &
feh --bg-fill ~/pictures/wallpapers/dvorak/wallhaven-v9vjm3.jpg &
xbanish &

### System ###
#setxkbmap us -variant colemak &
picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true" &
lxqt-policykit-agent &
xset s off -dpms &
modprobe vendor-reset
dunst &
dbus-launch --sh-syntax --exit-with-no-session; pulseaudio --kill; pipewire &
pipewire-pulse &
mpd &

## Keyboard 
xmodmap ~/.Xmodmap &
sxhkd -c /home/karson777/.config/sxhkd/sxhkdrc &

### Xrandr
xrandr --newmode "1920x1080_75.00"  220.75  1920 2064 2264 2608  1080 1083 1088 1130 -hsync +vsync
xrandr --addmode HDMI-A-0 "1920x1080_75.00"
xrandr --output HDMI-A-0 --mode 1920x1080_75.00 --rate 75
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 165.00

### Panel ###
slstatus &

### Applications ###
#nextcloud &
mullvad-vpn &
#st -e gomuks &
#st -e pulsemixer & 
#st -e ncmpcpp &
#noisetorch &

### WM ###
exec dwm
