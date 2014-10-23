# If we have virtualenvwrapper source it now
if [[ -x $(whiff virtualenvwrapper.sh) ]]; then
	source $(whiff virtualenvwrapper.sh)
fi

alias pip_upgrade_all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"
