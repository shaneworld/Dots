picom --config ~/.config/picom/picom.conf &
# Hide cursor while using the kb
xbanish &
setxkbmap -option "ctrl:nocaps"
xset r rate 300 50
# xautolock -time 10 -locker slock &
xautolock -time 10 -locker "slock" -killer "systemctl suspend" -killtime 1 &

# xrandr --output eDP --off --output DisplayPort-1 --mode 3840x2160 --rate 60

# xrandr --output eDP --off --output DisplayPort-0 --mode 3840x2160 --rate 60
# xrandr --output DisplayPort-0 --left-of eDP --mode 3840x2160 --rate 60
# feh --bg-scale ~/.config/wallpapers/zigzag.png &
feh --bg-fill $HOME/.config/wallpapers/tokyo.jpg
# clash-verge &
mihomo-party &
dunst &
blueman-applet &
nm-applet --indicator &
flameshot &
fcitx5 &
# slstatus &
dwmblocks &
