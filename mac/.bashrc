DEBUG_BASHRC=0

## Damn, this is ugly...  resetting the path so I can change work environment

export PATH="/usr/local/bin"
export PATH=${PATH}:"/usr/bin"
export PATH=${PATH}:"/bin"
export PATH=${PATH}:"/usr/sbin"
export PATH=${PATH}:"/sbin"

# pathmunge -------------------------------------------------------------------
#
# Stolen from /etc/profile on RedHat Linux
# Used to add stuff to your path, but it 
# won't add it if it's already there.
pathmunge () {
  # echo "  MUNGE: $1 $2"
  # echo "if [ ! \`echo $PATH | egrep -s \"(^|:)$1($|:)\"\` ] ; then"
  if [ ! `echo $PATH | egrep -s "(^|:)$1($|:)"` ] ; then
    # echo "    trace 1"
    if [ "$2" = "after" ] ; then
       # echo "    trace 2"
      PATH=$PATH:$1
    else
       # echo "    trace 3"
      PATH=$1:$PATH
    fi
  fi
}

# ldpathmunge -------------------------------------------------------------------
#
# Used to add stuff to your library path, but it 
# won't add it if it's already there.
ldpathmunge () {
  # echo "  MUNGE: $1 $2"
  # echo "if [ ! \`echo $LD_LIBRARY_PATH | egrep -s \"(^|:)$1($|:)\"\` ] ; then"
  if [ ! `echo $LD_LIBRARY_PATH | egrep -s "(^|:)$1($|:)"` ] ; then
    # echo "    trace 1"
    if [ "$2" = "after" ] ; then
       # echo "    trace 2"
      LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-"/usr/local/lib"}:$1
    else
       # echo "    trace 3"
      LD_LIBRARY_PATH=$1:${LD_LIBRARY_PATH:-"/usr/local/lib"}
    fi
  fi
}

# Work Settings ----------------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Work settings..."; fi
export GENDEV=${HOME}/Documents/dev
export RAILSDEV=${HOME}/Documents/dev/rails

export ALCHEMEEDEV=${HOME}/Documents/Alchemee/dev

if [ "foo$WORK" == "foo" ]
then
  export WORK=${ALCHEMEEDEV}
fi

# RVM Settings -----------------------------------------------------------------
#
pathmunge "/Users/doug/.rvm/bin"
rvm use default

# Java Settings ----------------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Skipping Java settings until I understand the mac better..."; fi
#export JAVA_ROOT=/cygdrive/c/Progra~1/Java/jdk1.6.0_23
#export JAVA_HOME=${JAVA_ROOT}
#export JAVA_HOME_W32=`/bin/cygpath -m $JAVA_HOME `
#pathmunge ${JAVA_HOME}/bin

# Assault Settings -------------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Assault settings..."; fi
export ASSAULT_HOME=${WORK}/assault/release
pathmunge ${ASSAULT_HOME}/bin

# Ant Definitions (common) -----------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Ant settings..."; fi
export ANT_OPTS="-Xms64m -Xmx256m"
#export ANT_OPTS="${ANT_OPTS} -DJAVA_HOME=${JAVA_HOME}"
export ANT_OPTS="${ANT_OPTS} -DASSAULT_HOME=${ASSAULT_HOME}"
export XALAN="${ASSAULT_HOME}/lib/xalan-2.7"
export ANT_OPTS="${ANT_OPTS} -Djava.endorsed.dirs=${XALAN}"
export LICENSE_DIR=${HOME}/licenses
export ANT_OPTS="${ANT_OPTS} -DLicense.dir=${LICENSE_DIR}"
export ANT_ARGS="-s build.xml"
pathmunge ${ASSAULT_HOME}/ant/bin


# Git settings -----------------------------------------------------------------
#
#export GIT_HOME=/cygdrive/c/Git
#pathmunge ${GIT_HOME}/bin after

# MYSQL Settings ---------------------------------------------------------------
#
#export MYSQL_HOME=/usr/local/mysql
#pathmunge ${MYSQL_HOME}/bin after
#ldpathmunge ${MYSQL_HOME}/lib after

# SML/NJ Settings --------------------------------------------------------------
#
pathmunge /usr/local/smlnj-110.75/bin after

# PostgreSQL Settings ----------------------------------------------------------
#
#if [ $DEBUG_BASHRC == 1 ]; then echo "Skipping PostgreSQL settings..."; fi
export PGSQL_HOME=/Applications/Postgres.app/Contents/MacOS
pathmunge ${PGSQL_HOME}/bin

# Android Development Kit Settings ---------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "ADK settings..."; fi
export ADT_HOME=$HOME/Documents/dev/adt-bundle-mac-x86_64-20130219
pathmunge ${ADT_HOME}/sdk/platform-tools after

# CDPATH Definitions -----------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "CDPATH settings..."; fi
export CDPATH=.
export CDPATH=${CDPATH}:${WORK}
export CDPATH=${CDPATH}:${RAILSDEV}
export CDPATH=${CDPATH}:${GENDEV}


# Personal Config --------------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Personal config settings..."; fi
pathmunge ${HOME}/.bin after
umask 022
#unset autologout

# Don't auto-complete CVS directories
export FIGNORE='\~:CVS:.class:.o'
export fignore='\~:CVS:.class:.o'

# Change the ls colors so that directories are white (i.e., NOT BLUE)

# echo "set colors"

export LS_COLORS='no=00:fi=00:di=01;37:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'

# Aliases ----------------------------------------------------------------------
#
alias la="ls -alF"
alias ll="ls -lF"
alias pd='pushd'
alias po='popd'
alias rm='/bin/rm -i'
alias m='less'

alias goro="sudo su -"
alias gopg="sudo su - postgres"
alias goaws='ssh -i /Users/doug/Documents/dev/DougPrice.pem ubuntu@ec2-107-22-99-76.compute-1.amazonaws.com'
alias goal='ssh deploy.aws.com'

alias psg="ps -ef | grep "
alias ep='echo $PATH | tr ":" "\n" '
alias el='echo $LD_LIBRARY_PATH | tr ":" "\n" '

alias ant="ant notest"

alias httpd='python -m SimpleHTTPServer 8090'

#alias cvss='cvs status | grep Status'
#alias cvsu="cvs -n update 2>&1 | grep -v 'update' | grep -v 'cvs server'"

alias vi='mvim'

alias gs='git status'
alias gl='git log'

alias rr='rake routes'
alias rrg='rake routes | grep'
alias ti='ruby -Itest '

alias tree='tree | less'
alias sql3='sqlite3 db/development.sqlite3'
alias sql3l='sqlite3 -line db/development.sqlite3'

# Change work environment
alias wa="export WORK=$ALCHEMEEWORK ; . ~/.bashrc"


# PROMPT ----------------------------------------------------------------------
#
#export PS1=[\u@\h \W]\$
#export PS1="\n*** \A \u@\h \w ***\n> "

PROMPT_COMMAND=build_prompt

check_success()
{
  if [ "$?" -eq 0 ]; then
    HIST_COLOR="$GREEN"
  else
    HIST_COLOR="$BOLD_RED"
  fi
}

parse_git_description()
{
  git describe 2> /dev/null  | sed -e 's/\(.*\)/ \[\1\]/'
}

parse_git_branch()
{
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

build_prompt()
{
  check_success
  gitBranch=$(parse_git_branch)
  if [ "$gitBranch" == " [(no branch)]" ]; then
    export PS1="\n($HIST_COLOR\!$BLACK) $CYAN\t $DARK_GREEN\u$BLACK@$DARK_GREEN\h$BLACK:$CYAN\w$BOLD_RED\$(parse_git_description)$BLACK\n\$ "
  else
    export PS1="\n($HIST_COLOR\!$BLACK) $CYAN\t $DARK_GREEN\u$BLACK@$DARK_GREEN\h$BLACK:$CYAN\w$BOLD_GREEN\$(parse_git_branch)$BLACK\n\$ "
  fi
}

# echo "define colors"

BLACK="\[\033[0m\]"
BOLD_BLACK="\[\033[1;30m\]"
RED="\[\033[0;31m\]"
BOLD_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
BOLD_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
BOLD_YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
BOLD_BLUE="\[\033[1;34m\]"
MAUVE="\[\033[0;35m\]"
BOLD_MAUVE="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
BOLD_CYAN="\[\033[1;36m\]"
WHITE="\[\033[0;37m\]"
DARK_GREEN="\[\033]0;\w\007\033[32m\]"


