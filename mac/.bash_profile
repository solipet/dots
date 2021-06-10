
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

. ~/.bashrc

##
# Your previous /Users/doug/.bash_profile file was backed up as /Users/doug/.bash_profile.macports-saved_2015-02-02_at_16:35:26
##

# MacPorts Installer addition on 2015-02-02_at_16:35:26: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="/usr/local/opt/terraform@0.12/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
