if [ -d /opt/rust ]; then
	append_path /opt/rust/bin
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/rust/lib
fi

[ ! -x $(whiff rust) ] && return
