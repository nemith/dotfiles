# skip if not on fb server
[ ! -f /etc/fbwhoami ] && return

source /etc/fbwhoami
[ "$DEVICE_HOSTNAME_SCHEME" != "dev" ] && return

# Source Facebook definitions
source /etc/bashrc
source /usr/facebook/ops/rc/master.bashrc

export LOCALUSERDIR=/data/users/bbennett
export FBCODE=$HOME/fbcode
export CODE=$HOME/local/code

export HOMEBREW_PREFIX="$LOCALUSERDIR/linuxbrew"
export HOMEBREW_CACHE="$HOMEBREW_PREFIX/cache"

if [ -d $HOMEBREW_PREFIX ]; then
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"
fi

# <meme name='aliens'>Java</meme>
append_path /opt/ant/bin:
export ANT_HOME=/opt/ant

function fbhostname {
    host=$1
    [ "$host" == "" ] && host=$(hostname)

    # remove known tlds
    echo $(echo $host | sed 's/\.\(facebook.com\|thefacebook.com\|tfbnw.net\)$//')
}

# Set gopath if we are on our devserver
if [ -d /data/users/$USER/go ]; then
    export GOPATH=/data/users/$USER/go
    append_path $GOPATH/bin
fi


function fbgopath {
    shopt -s nullglob

    # Remove all old fbcode gopaths
    GOPATH=$(echo $GOPATH | sed "s,$FBCODE/[^:]*:\?,,g")
    GOPATH=${GOPATH/%:/}

    for project in $(fbmake what | cut -d ' ' -f2); do
            project_build_dir="$FBCODE/_build/dbg/$project"
            for golive_linktree_dir in $project_build_dir/*.golive.linktree; do
            GOPATH=$GOPATH:$golive_linktree_dir
            done
    done

    echo $GOPATH
    export GOPATH
}

alias prod='FBNET_SANDBOX="*production*"'
alias fbnet_db='db cdb.fbnet'
