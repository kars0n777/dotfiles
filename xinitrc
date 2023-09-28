#!/bin/sh
### karson777's xinitrc ###
#   github.com/kars0n777

### Export ###
export PATH="${PATH}:${HOME}/scripts" 
## qt5ct as qtthememanager 
export QT_QPA_PLATFORMTHEME=qt5ct
#unset QT_STYLE_OVERRIDE # kvantum as qtthememanager
export QT_STYLE_OVERRIDE=kvantum

### Xrandr
xrandr --newmode "1920x1080_75.00"  220.75  1920 2064 2264 2608  1080 1083 1088 1130 -hsync +vsync
xrandr --addmode HDMI-1 "1920x1080_75.00"
xrandr --output DP-3 --primary --mode 1920x1080 --pos 1920x420 --rotate normal  --rate 165.00 --output HDMI-1 --mode "1920x1080_75.00" --pos 3840x0 --rotate right --rate 75 --output DVI-D-1 --mode 1920x1080 --pos 0x420 --rotate normal 

### Appearence ### 
#feh --bg-fill ~/pictures/wallpapers/xinit/kpn06tol2x271.webp &
feh --bg-fill ~/pictures/wallpapers/xinit/$("ls" ~/pictures/wallpapers/xinit | shuf --head-count=1) & 
xbanish & 

### System ###
#xmodmap ~/.Xmodmap &
xset s off -dpms &
modprobe vendor-reset
dunst &
nm-applet &
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &
mpd &
picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true" --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
syncthing &
#xinput set-button-map 14 3 2 1 &

### Applications ###
sxhkd &
slstatus &
mullvad-vpn &

### WM ###
exec dwm
