powerline_dirs=(
	$(python -c "import sys; print ' '.join([p+'/powerline' for p in sys.path[1:]])")
 	'/usr/share/powerline'
)
for dir in "${powerline_dirs[@]}"; do
	if [ -d "$dir" ]; then
		export POWERLINE_DIR=$dir
    source "$POWERLINE_DIR/bindings/bash/powerline.sh"
    break;
  fi
done
