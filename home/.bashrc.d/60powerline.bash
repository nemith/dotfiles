powerline_dirs=(
 	'/usr/share/powerline'
	$(python -c "import sys; print '/powerline '.join(sys.path[1:])")
)
for dir in ${powerline_dirs[@]}; do
	if [ -f $dir/bindings/bash/powerline.sh ]; then
		export POWERLINE_DIR=$dir
        source $dir/bindings/bash/powerline.sh
        break;
    fi
done
