alias irc="mosh coachz.inetpro.org -- tmux attach -d"

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