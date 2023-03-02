# Created by newuser for 5.6.2

# autoload -Uz compinit
# compinit

autoload -U promptinit; promptinit
prompt pure

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz colors
colors

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2
# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 間違えた時に似たコマンドを表示
setopt correct
# Sat Dec 22 18:33:55 2018

# emacsキーバインド
bindkey -e

# cdコマンドの省略
setopt auto_cd

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 直前のコマンドと同じなら、履歴に残さない
setopt HIST_IGNORE_DUPS
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時起動したzshの間でヒストリを共有
setopt share_history

# backspace,deleteキーを使えるよに
stty erase ^H
bindkey "^[[3~" delete-char

# pathを通す
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs.d/script:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$HOME/.ghcup/ghc/8.10.7/bin/:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/toshiaki/.local/lib"
export QT_QPA_PLATFORMTHEME="qt5ct"

# export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin/:$PATH"

# 言語を英語にする
export LANG=en_US.utf-8

# エイリアス
alias la='ls -a'
alias ll='ls -lh'
alias rm='rm -i'
alias cp='cp -p'
alias startx='startx -- -dpi 138'
# alias ghc="stack ghc"
# alias ghci="stack ghci"
# alias runghc="stack runghc"
# alias runhaskell="stack runghc"
alias pacmanlist="pacman -Qqe > ~/projects/dotfiles/.pkglist"

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# 接尾辞エイリアス
alias -s mkv=mpv
alias -s mp4=mpv
alias -s avi=mpv
alias -s wav=mpv
alias -s exe=wine


case $(uname -n) in
    "ArchLinuxonLaptopPC" ) alias startx='startx' ;;
    "archlinuxhonda" ) alias startx='startx -- -dpi 138' ;;
    "sx12toshiaki" )
        function open() {
            if [ $# != 1 ]; then
                explorer.exe .
            else
                if [ -e $1 ]; then
                    cmd.exe /c start $(wslpath -w $1) 2> /dev/null
                else
                    echo "open: $1 : No such file or directory"
                fi
            fi}

        # PS1='[\u@\h \W]\$ '
        setxkbmap -layout us > /dev/null 2>&1
        setxkbmap -option ctrl:swap_rwin_rctl > /dev/null 2>&1
        export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0;;
esac



# settings for wsl
# case $(uname -n) in
#     sx12toshiaki)
#     function open() {
#     if [ $# != 1 ]; then
#         explorer.exe .
#     else
#         if [ -e $1 ]; then
#             cmd.exe /c start $(wslpath -w $1) 2> /dev/null
#         else
#             echo "open: $1 : No such file or directory"
#         fi
#     fi
#     }

#     PS1='[\u@\h \W]\$ '
#     setxkbmap -layout us > /dev/null 2>&1
#     setxkbmap -option ctrl:swap_rwin_rctl > /dev/null 2>&1
#     export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0;;
# esac


# autoload -Uz promptinit
# promptinit

# # This will set the default prompt to the walters theme
# prompt walters
# # PS1="%{$fg[cyan]%}[${USER}@${HOST%%.*} %1~]%(!.#.$)${reset_color} "
# PROMPT="%{$fg[cyan]%}[@%m]%(!.#.$)${reset_color}"
# RPROMPT="%~"

# function mm() {
#     mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
#     }

# case $TERM in
#   linux)
#       LANG=C;;
#   *)
#       LANG=ja_JP.UTF-8 ;;
# esac

# case $TERM in
#     linux) LANG=C ;;
#     *) LANG=ja_JP.UTF-8 ;;
# esac
