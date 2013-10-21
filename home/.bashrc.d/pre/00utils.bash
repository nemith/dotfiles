# PATH munging tools
append_path() { NEW=${1/%\//}; [[ -d $NEW ]] || return; remove_path $NEW; export PATH="$PATH:$NEW"; }
prepend_path() { NEW=${1/%\//}; [[ -d $NEW ]] || return; remove_path $NEW; export PATH="$NEW:$PATH"; }
remove_path() {
    # New format not supported by some old versions of awk
    # PATH=`echo -n "$PATH" | awk -v RS=: -v ORS=: '$0 != "'$1'"'`
    PATH=`echo -n "$PATH" | awk  'BEGIN { RS=":"; ORS=":" } $0 != "'$1'" '`
    export PATH=${PATH/%:/}
}
