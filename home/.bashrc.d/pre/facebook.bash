# Continue if not on fb server
[ ! -f /etc/fbwhoami ] && return

# Source Facebook definitions
source /etc/bashrc
source /mnt/vol/engshare/admin/scripts/master.bashrc
source /home/engshare/admin/scripts/ssh/manage_agent.sh
source "$ADMIN_SCRIPTS"/ssh/manage_rootcanal.sh


function fbhostname {
    host=$1
    [ "$host" == "" ] && host=$(hostname)

    # remove known tlds
    echo $(echo $host | sed 's/\.\(facebook.com\|thefacebook.com\|tfbnw.net\)$//')
}
