
powerline_dirs+=(
	'/usr/share/powerline'
	'/usr/share/powerline/bindings'
	$(python -c "import sys; print ' '.join([p+'/powerline/bindings' for p in sys.path[1:]])")
)

if [ -x "$(whiff python3)" ]; then
  powerline_dirs+=(
	  $(python3 -c "import sys; print(' '.join([p+'/powerline/bindings' for p in sys.path[1:]]))")
  )
fi


for dir in "${powerline_dirs[@]}"; do
	if [ -d "$dir" ]; then
	export POWERLINE_DIR=$dir
    source "$POWERLINE_DIR/bash/powerline.sh"
    break;
  fi
done
