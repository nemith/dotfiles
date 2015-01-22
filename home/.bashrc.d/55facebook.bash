# skip if not on fb server
[ ! -f /etc/fbwhoami ] && return

# Source Facebook definitions
source /etc/bashrc
source /mnt/vol/engshare/admin/scripts/master.bashrc
source /home/engshare/admin/scripts/ssh/manage_agent.sh
 
export FBCODE=$HOME/fbcode
export CODE=$HOME/local/code

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
