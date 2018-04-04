if [ -d $HOME/.cargo/bin ]; then
    append_path $HOME/.cargo/bin
elif [ -d /opt/rust ]; then
	append_path /opt/rust/bin
fi

[ ! -x $(whiff rustc) ] && return
