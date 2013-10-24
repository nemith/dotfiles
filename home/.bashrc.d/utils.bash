distro() {
    if [[ $(uname -a) == 'Linux' ]]; then
        if [[ -f /etc/gentoo-release ]]; then
          distro='gentoo'
        elif [[ -f /etc/redhat-release ]]; then
          distro=$(awk '{ print $1 }' /etc/redhat-release)
        elif [[ -f /etc/debian_version ]]; then
          distro='debian'
        elif [[ -f /etc/lsb*release ]]; then
          eval `cat /etc/lsb*release`
          distro=$DISTRIB_ID
        fi
        return $(echo $distro |tr "[:upper:]" "[:lower:]")
    fi
    return
}

# Source a script if it is executable
source_script() {
    for script in $*; do
        if [[ -x $script ]]; then
            source $script
        fi
    done
}

# PATH munging tools
append_path() { NEW=${1/%\//}; [[ -d $NEW ]] || return; remove_path $NEW; export PATH="$PATH:$NEW"; }
prepend_path() { NEW=${1/%\//}; [[ -d $NEW ]] || return; remove_path $NEW; export PATH="$NEW:$PATH"; }
remove_path() {
    # New format not supported by some old versions of awk
    # PATH=`echo -n "$PATH" | awk -v RS=: -v ORS=: '$0 != "'$1'"'`
    PATH=`echo -n "$PATH" | awk  'BEGIN { RS=":"; ORS=":" } $0 != "'$1'" '`
    export PATH=${PATH/%:/}
}

# Colors
function color()   { echo -ne "\[\033[38;5;$1m\]"; }
function bold()    { echo -ne "\[\033[1m\]"; }
function nocolor() { echo -ne "\[\033[0m\]"; }