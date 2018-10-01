#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias E='emaccsclient -t'
alias kill-emacs="emacsclient -e '(kill-emacs)'"
alias emacs="emacs -nw"
alias xk="sudo xkeysnail ~/config.py"

PS1='[\u@\h \W]\$ '

export LANG=en_US.UTF-8
