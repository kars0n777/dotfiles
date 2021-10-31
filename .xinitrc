## System
picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true" &
#lxsession &

## Appearence
#feh --bg-fill ~/pictures/wallpapers/serial-experiments-lain-room-1514392856.jpg &
nitrogen --restore &
export QT_QPA_PLATFORMTHEME=qt5ct 
unset QT_STYLE_OVERRIDE

## Panel
slstatus &
#blueman-applet & 
volumeicon &
#lxqt-connman-applet &

## Keyboard
xmodmap ~/.Xmodmap &
sxhkd &

## Applications
discord &
element-desktop &
keepassxc &
moc &
alacritty -e mocp &
noisetorch &

## WM
exec dwm
