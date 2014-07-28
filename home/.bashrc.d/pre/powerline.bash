PY_USER_SITE=$(python -m site --user-site)
PY_SYSTEM_SITE=$(python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")

for pydir in $PY_USER_SITE $PY_SYSTEM_SITE; do
    if [ -d $pydir/powerline ]; then
        export POWERLINE_DIR=$pydir/powerline

        # Powerline for bash
        source $POWERLINE_DIR/bindings/bash/powerline.sh
        break;
    fi
done
