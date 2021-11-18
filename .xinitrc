## System
picom -b --focus-exclude "x = 0 && y = 0 && override_redirect = true" &
lxqt-policykit-agent &

## Appearence
nitrogen --restore &

## qt5ct as qt theme
#export QT_QPA_PLATFORMTHEME=qt5ct
#unset QT_STYLE_OVERRIDE

## kvantum as qt theme
export QT_STYLE_OVERRIDE=kvantum

## Panel
slstatus &
volumeicon &
connman-gtk --tray &
dunst &

## Keyboard
xmodmap ~/.Xmodmap &
sxhkd &

## Applications
noisetorch &
element-desktop &
keepassxc &
alacritty -e mocp &
#mullvad-vpn &

## WM
exec dwm
