# Don't do anything if not running interactively
if [[ $- != *i* ]]; then
    return
fi

# Keep plenty of history; unlimited, if we have >=4.3
if ((${BASH_VERSINFO[0]} >= 4 \
&& 10#${BASH_VERSINFO[1]%%[![:digit:]]*} >= 3)); then
    HISTFILESIZE=-1
    HISTSIZE=-1
else
    HISTFILESIZE=1000000
    HISTSIZE=1000000
fi

# Ignore duplicate commands and whitespace in history
HISTCONTROL=ignoreboth

# Keep the times of the commands in history
HISTTIMEFORMAT='%F %T  '

# Never beep at me
setterm -bfreq 0 2>/dev/null

# Turn off flow control and control character echo
stty -ixon -ctlecho 2>/dev/null

# Autocorrect fudged paths in cd calls
shopt -s cdspell
# Update the hash table properly
shopt -s checkhash
# Update columns and rows if window size changes
shopt -s checkwinsize
# Put multi-line commands onto one line of history
shopt -s cmdhist
# Include dotfiles in pattern matching
shopt -s dotglob
# Enable advanced pattern matching
shopt -s extglob
# Append rather than overwrite Bash history
shopt -s histappend
# Don't use Bash's builtin host completion
shopt -u hostcomplete
# Don't warn me about new mail all the time
shopt -u mailwarn
# Ignore me if I try to complete an empty line
shopt -s no_empty_cmd_completion
# Use programmable completion, if available
shopt -s progcomp
# Warn me if I try to shift when there's nothing there
shopt -s shift_verbose
# Don't use PATH to find files to source
shopt -u sourcepath

# These options only exist since Bash 4.0-alpha
if ((${BASH_VERSINFO[0]} >= 4)); then
    # Warn me about stopped jobs when exiting
    shopt -s checkjobs
    # Autocorrect fudged paths during completion
    shopt -s dirspell
    # Enable double-starring paths
    shopt -s globstar
fi

# Source a script if it is executable
source_script() {
    [[ "${@:-1}" == "force" ]] && FORCE=1
    for script in $*; do
        if [[ -x $script || "$FORCE" == 1 ]]; then
            source $script
        fi
    done
}

# Execute scripts under .bashrc.d
if [[ -d $HOME/.bashrc.d ]]; then
    source_script "$HOME"/.bashrc.d/*.bash
fi

unset -v config
