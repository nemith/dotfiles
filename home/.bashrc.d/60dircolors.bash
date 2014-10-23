# New dircolors

if [ -x $(which dircolors gdircolors) ]; then
	eval $($(which dircolors gdircolors) $HOME/.dircolors/solarized/dircolors.256dark)
fi