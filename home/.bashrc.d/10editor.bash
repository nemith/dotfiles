if [ -x "$(whiff nvim)" ]; then
  export EDITOR="nvim"
	alias vi='nvim'
	alias vim='nvim'
else
  export EDITOR="vim"
	alias vi='vim'
fi
