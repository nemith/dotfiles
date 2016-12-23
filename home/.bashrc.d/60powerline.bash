
powerline_dirs+=(
	'/usr/share/powerline'
	'/usr/share/powerline/bindings'
	$(python3 -c "import sys; print(' '.join([p+'/powerline/bindings' for p in sys.path[1:]]))")
	$(python -c "import sys; print ' '.join([p+'/powerline/bindings' for p in sys.path[1:]])")
)

for dir in "${powerline_dirs[@]}"; do
	if [ -d "$dir" ]; then
	export POWERLINE_DIR=$dir
    source "$POWERLINE_DIR/bash/powerline.sh"
    break;
  fi
done
