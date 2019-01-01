# Created by newuser for 5.6.2

autoload -Uz compinit
compinit

# plugins
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
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

# コマンドミスを修正
setopt correct


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

# エイリアス
alias la='ls -a'
alias ll='ls -lh'

alias rm='rm -i'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# 接尾辞エイリアス
alias -s mkv=mplayer
alias -s mp4=mplayer
alias -s avi=mplayer
alias -s wav=mplayer

autoload -Uz promptinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

# PS1="%{$fg[cyan]%}[${USER}@${HOST%%.*} %1~]%(!.#.$)${reset_color} "
PROMPT="%{$fg[cyan]%}[@%m]%(!.#.$)${reset_color}"
RPROMPT="%~"
