warn_install() {
	if [ -z "$2" ]; then
		command="brew install $1"
	else
		command="$2"
	fi
	echo "Please install '$1' with '$command'"
}


if [ -x $(which brew) ]; then
	BREW_PREFIX=$(brew --prefix)
else
	warn_install "homebrew" "ruby -e \"$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)\""
	BREW_PREFIX=/usr/local
fi

# Make sure brew's bin and sbin are in the path
prepend_path $BREW_PREFIX/bin
prepend_path $BREW_PREFIX/sbin

# Include brew installed bash_compleitions
if [ -f $BREW_PREFIX/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
else
	warn_install "compleition"
fi

# Use GNU ls if coreutils are install.  Otherwise turn on BSD ls colors
if [[ -x $BREW_PREFIX/bin/gls ]]; then
	alias ls='gls --color=auto -F'
else
	alias ls='ls -GF'
fi

# Add brew pythonpath
if [[ -d $BREW_PREFIX/lib/python2.7/site-packages ]]; then
	export PYTHONPATH=$BREW_PREFIX/lib/python2.7/site-packages:$PYTHONPATH
fi

# Add users site-packages bin to path
if [ -d "$HOME/Library/Python/2.7/bin"  ]; then
    append_path "$HOME/Library/Python/2.7/bin"
fi

# Set out editor to Sublime Text 2 if we have it
if [[ -x $(which subl) ]]; then
	export EDITOR='subl -w'
fi

# Support fancy command-line printing
if [[ -x $(which enscript) ]]; then
	alias print="enscript --margins=36:36:36:36 -DDuplex:true --font=Courier8 --word-wrap --media=Letter --fancy-header"
else
	warn_install "enscript"
fi

# Quick alias for updating all homebrewed apps
alias update="brew update && brew upgrade"


# Function for switching java 
alias java_ls='/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d_\d\d" | cut -d , -f 1 | colrm 1 4 | grep -v Home'

function java_use() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}


