#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources


export DefaultIMModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx5 &

# dropbox &
# megasync &

# if [ $(hostname) = "archlinuxhonda" ]; then
#     # export GDK_SCALE=2
#     export QT_SCALE_FACTOR=1.5
#     # xrandr --output DP-0 --scale 0.9x0.9
# fi

export LANG=ja_JP.UTF-8
export EXWM=enable

case $(uname -n) in
    "sx12toshiaki" ) xkbcomp -I$HOME/.xkb/ ~/.xkb/keymap/sx12 $DISPLAY > /dev/null 2>&1;;
esac

xhost +SI:localuser:$USER
export _JAVA_AWT_WM_NONREPARENTING=1
# xsetroot -cursor_name left_ptr

xset r rate 250 40
exec emacs
# exec cutefish-session
# exec dbus-launch --exit-with-session --sh-syntax emacs
