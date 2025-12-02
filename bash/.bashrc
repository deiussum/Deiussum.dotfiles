#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[37m\][\[\e[32m\]\u@\h\[\e[00m\]:\[\e[34m\]\w\[\e[37m\]]\[\e[00m\]$ '

export VISUAL=vim
export EDITOR=vim
export STOW_DIR=~/Deiussum.dotfiles

