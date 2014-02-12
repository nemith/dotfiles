# Continue if not on fb server
[ ! -f /etc/fbwhoami ] && return

# Source Facebook definitions
source_script /mnt/vol/engshare/admin/scripts/master.bashrc
source_script /home/engshare/admin/scripts/ssh/manage_agent.sh
source "$ADMIN_SCRIPTS/ssh/manage_rootcanal.sh"
