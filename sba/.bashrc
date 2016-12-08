# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# User specific prompt
[[ -f "$HOME/.bash_prompt" ]] && source "$HOME/.bash_prompt"

# HUBZone specific settings
[[ -f "$HOME/.hubzone" ]] && source "$HOME/.hubzone"
