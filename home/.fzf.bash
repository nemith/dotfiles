# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bbennett/.fzf/bin* ]]; then
  export PATH="$PATH:/home/bbennett/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bbennett/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/bbennett/.fzf/shell/key-bindings.bash"

