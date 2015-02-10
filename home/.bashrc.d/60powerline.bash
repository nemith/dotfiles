for pydir in $(python -c "import sys; print ' '.join(sys.path[1:])"); do
	if [ -d $pydir/powerline ]; then
        export POWERLINE_DIR=$pydir/powerline

        # Powerline for bash
        source $POWERLINE_DIR/bindings/bash/powerline.sh
        break;
    fi
done
