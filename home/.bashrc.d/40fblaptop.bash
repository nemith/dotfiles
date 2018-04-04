# skip if not on fb laptop
[ ! -f /etc/fb-machine-owner ] && return

if [ -d "$HOME/local/arcanist/bin" ]; then
  export PATH="$HOME/local/arcanist/bin:$PATH"
fi

if [ -d "/opt/fbhg/bin" ]; then
  export PATH="/opt/fbhg/bin:$PATH"
fi

if [ -d "$HOME/local/buck/bin" ]; then
	export PATH="$HOME/local/buck/bin:$PATH"
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


function dev {
    [ "$(klist -cl | grep Expired)" != "" ] && kinit
    mosh -6 dev -- tmux attach
}
