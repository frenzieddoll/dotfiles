# Created by newuser for 5.6.2

autoload -Uz compinit
compinit

checkExist () {
    ls $1 > /dev/null 2>&1
}

autoload -U promptinit; promptinit

temp="/usr/share/zsh/functions/Prompts/prompt_pure_setup"
checkExist $temp && prompt pure

# # plugins
temp="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
checkExist $temp && source $temp

temp="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
checkExist $temp && source $temp

# prompt pure
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/toshiaki/.local/lib"
# 環境変数の設定
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx

# 言語を英語にする
export LANG=en_US.utf-8

# エイリアス
alias la='ls -a'
alias ll='ls -lh'
alias rm='rm -i'
alias cp='cp -p'
alias pacmanlist="pacman -Qqe > ~/projects/dotfiles/.pkglist"
alias reflectorjp="sudo reflector --country \"Japan\" --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"


# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# 接尾辞エイリアス
alias -s mkv=mpv
alias -s mp4=mpv
alias -s avi=mpv
alias -s wav=mpv
# alias -s exe=wine

# stable diffusion
alias drun='docker run -it --network=host --device=/dev/kfd --device=/dev/dri --group-add=video --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/pwd'

which gh > /dev/null 2>&1 && eval "$(gh completion -s zsh)"

function radeonPro () {
    export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
    export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
    export RADV_PERFTEST=rt,gpl,nv_ms # Ray Tracing等の有効化
    export HSA_OVERRIDE_GFX_VERSION=10.3.0
}

case $(uname -n) in
    "archlinuxhonda")
        radeonPro;;
    "sx12toshiaki")
        # PS1='[\u@\h \W]\$ '
        setxkbmap -layout us > /dev/null 2>&1
        setxkbmap -option ctrl:swap_rwin_rctl > /dev/null 2>&1
        # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
        ;;
    "JPC20627141" | "JPC20661318")
        export LIBGL_ALWAYS_INDIRECT=1
        export PYTHONPATH="$HOME/Documents/programing/python/modules:$PYTHONPATH"
        ;;
esac

case $(uname -r | grep microsoft > /dev/null 2>&1 && echo wsl || echo not_wsl) in
    "wsl")
        open () {
            if [ $# != 1 ]; then
                explorer.exe .
            else
                if [ -e $1 ]; then
                    cmd.exe /c start $(wslpath -w $1) 2> /dev/null
                else
                    echo "open: $1 : No such file or directory"
                fi
            fi
        }
        ;;
esac


# for vterm
if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
    source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh

    if which hostname > /dev/null 1>&2; then
        echo $(hostname)
    else
        vterm_prompt_end(){
            vterm_printf "51;A$(whoami)@${HOSTNAME}:$(pwd)"
        }
    fi

    # Initialize TITLE
    print -Pn "\e]2;%m:%2~\a"
fi

# private ファイルの読み込み
# if [ -e $HOME/private/API/api.sh ]; then
#     while read line; do
#         eval $line
#     done < $HOME/private/API/api.sh
# fi
