# TODO: Check for 

# If we have virtualenvwrapper source it now
if [[ -x $(which virtualenvwrapper.sh) ]]; then
	source $(which virtualenvwrapper.sh)
fi

alias pip_upgrade_all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"