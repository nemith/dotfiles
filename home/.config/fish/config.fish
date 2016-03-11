# powerline prompt
set powerline_dirs /usr/share/powerline (python -c "import sys; print '/powerline '.join(sys.path[1:])")
for dir in $powerline_dirs
	set plfunc $dir/bindings/fish/powerline-setup.fish
    if test -e $plfunc
		set -x POWERLINE_DIR $dir
		source $plfunc
		powerline-setup
		break
	end
end
