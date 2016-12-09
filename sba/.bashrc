# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# rvm
[[ $DEBUG_BASHRC = 1 ]] && echo "Loading rvm"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# nvm
[[ $DEBUG_BASHRC = 1 ]] && echo "Loading nvm"
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# User specific aliases and functions
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# User specific prompt
[[ -f "$HOME/.bash_prompt" ]] && source "$HOME/.bash_prompt"

# HUBZone specific settings
[[ -f "$HOME/.hubzone" ]] && source "$HOME/.hubzone"
