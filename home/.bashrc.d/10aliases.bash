alias vps="mosh coachz.brbe.net -- tmux attach -d"
alias dev="perl -E ' print \"\e[?1005h\e[?1002h\" ' && mosh dev -- tmux attach -t work -d"
alias mosh="perl -E ' print \"\e[?1005h\e[?1002h\" ' && mosh"

# Colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Color diff if you got it
if [ -x $(which colordiff) ]; then
	alias diff='colordiff'
fi

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Use sudo instead of su if availabe
if [ -x $(which sudo) ]; then
	alias su='sudo -i'
fi

if [ -x $(whiff nvim) ]; then
	alias vi='nvim'
	alias vim='nvim'
else
	alias vi='vim'
fi

alias nssh='TERM=screen ssh -o PubkeyAuthentication=no'
alias nscp='scp -o PubkeyAuthentication=no'

