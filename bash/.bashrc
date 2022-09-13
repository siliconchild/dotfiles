#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# keychain
eval $(keychain --eval --noask --quiet id_rsa ~/.ssh/id_rsa)

# Environmental Variables
export SYSTEMD_EDITOR="/usr/bin/nvim"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="${PATH}:/home/alwin/.node_modules/bin"
export PATH="${PATH}:/home/alwin/.local/bin"
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
wifi () {
	base_cmd="nmcli device wifi"
	if [[ $1 = base ]]
	then
		eval "$base_cmd connect keralavision"
	elif [[ $1 = room ]]
	then
		eval "$base_cmd connect keralavision_EXT"
	else
		eval "$base_cmd" "$1"
	fi
}

#[ x$DISPLAY != x ] && pfetch
#eval "$(zoxide init bash)"
eval "$(starship init bash)"

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/home/alwin/.config/netlify/helper/path.bash.inc' && source '/home/alwin/.config/netlify/helper/path.bash.inc'
