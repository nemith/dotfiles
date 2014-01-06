# TODO: check to see if go exists

# Set GOPATH
export GOPATH=$HOME/Devel/go

#Add GOPATH/bin to path
append_path $GOPATH/bin

# Add  gocellar libexec/bin to path
append_path "$(brew --prefix go)/libexec/bin"