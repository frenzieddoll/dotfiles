#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias E='emaccsclient -t'
alias kill-emacs="emacsclient -e '(kill-emacs)'"
alias emacs="emacs -nw"
alias open='xdg-open'
# alias sdb="sudo ntfs-3g /dev/sdb2 /mnt/sdb/"
# alias sdc="sudo ntfs-3g /dev/sdc1 /mnt/sdc/"

PS1='[\u@\h \W]\$ '

exec fish

export LANG=en_US.UTF-8
