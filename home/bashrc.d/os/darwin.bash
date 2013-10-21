
if [ -x $(which brew) ]; then
	BREW_PREFIX=$(brew --prefix)
else
	echo "Please install 'homebrew' with 'ruby -e \"$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)\""
	BREW_PREFIX=/usr/local
fi

# Make sure brew's bin and sbin are in the path
prepend_path $BREW_PREFIX/bin
prepend_path $BREW_PREFIX/sbin

# Include brew installed bash_compleitions
if [ -f $BREW_PREFIX/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
else
	echo "Please install 'bash-compleition from homebrew with 'brew install bash-completion'"
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

# Set out editor to Sublime Text 2 if we have it
if [[ -x $(which subl) ]]
	export EDITOR='subl -w'
fi