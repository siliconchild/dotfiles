#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Environmental Variables
export SYSTEMD_EDITOR="/usr/bin/nvim"
export PATH="${PATH}:/home/alwin/.node_modules/bin"
export npm_config_prefix=~/.node_modules
export PF_INFO="ascii title os kernel uptime pkgs wm memory"
export HISTCONTROL=ignoredups
export HISTSIZE=5000
#Aliases
alias sudo="sudo "
alias ls="exa --group-directories-first --icons -al -s name"
alias ..="cd .."
alias paru="paru --skipreview"
alias cp=fcp
alias vi=nvim
alias du=dust
alias ping="prettyping --nounicode"
alias htop=ytop
alias nd="npm run dev"
alias nb="npm run build"

#Functions
mcd () {
  mkdir "$1"
  cd "$1"
}
lc () {
	cd "$1"
	ls 
}

#[ x$DISPLAY != x ] && pfetch
eval "$(zoxide init bash)"
eval "$(starship init bash)"
