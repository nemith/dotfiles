# skip if not on fb laptop
[ ! -f /etc/fb-machine-owner ] && return

export DEVTOOLS=$HOME/devtools

if [ -d "$DEVTOOLS/arcanist/bin" ]; then
  export PATH="$DEVTOOLS/arcanist/bin:$PATH"
fi

function fbhostname {
    host=$1
    [ "$host" == "" ] && host=$(hostname)

    # remove known tlds
    echo $(echo $host | sed 's/\.\(facebook.com\|thefacebook.com\|tfbnw.net\)$//')
}

function buck_debug {
	lsof -i:8888 | tail -n +2 | awk '{ print $2 }' | xargs -L1 kill -9
	export BUCK_DEBUG_MODE=1
	export NO_BUCKD=1
}
