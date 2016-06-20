if [ -d /opt/rust ]; then
	append_path /opt/rust/bin
fi

[ ! -x $(whiff rustc) ] && return
