if [ -x "$(whiff powerline-go)" ]; then
    modules="venv,user,host,ssh,cwd,git,hg,jobs,exit"
    path_aliases="/data/users/bbennett/fbsource/fbcode=@FBCODE"


    function _update_ps1() {
        PS1="$(powerline-go -modules $modules -path-aliases $path_aliases -error $?)"
    }

    if [ "$TERM" != "linux" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
else
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
fi

