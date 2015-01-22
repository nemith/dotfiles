# syntax highlighted less!
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

export CODE=$HOME/code

# Vim man
vman() {
    vim -c "SuperMan $*"

    if [ "$?" != "0"  ]; then
        echo "No manual entry for $*"
    fi
}

