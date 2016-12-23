# New dircolors

if [ -x $(whiff dircolors gdircolors) ]; then
	eval $($(whiff dircolors gdircolors) $HOME/.dircolors.d/solarized/dircolors.256dark)
fi
