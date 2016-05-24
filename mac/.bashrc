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
export COURSERA=${HOME}/Documents/Courses/AlgorithmsII/assignments

export ALCHEMEEDEV=${HOME}/Documents/Alchemee/dev
export FRACTOGRAFDEV=${HOME}/Documents/Fractograf/dev
export RAILS_ENV_ABBREV=dev
export RAILS_APP=fractograf
export RAILS_ROLE=www
export RAILS_SECRET_KEY_BASE='4c8bde8d56b4e9a37621bdb3392ddc993f79794f59bcd90f8df6f5c5abb57c5d6db1ff18c0e3adb2b5e5636da02ddffc58544a3f3846f7289ec0243db83f8be9'
export RAILS_AUTH_SECRET_KEY_BASE='86847ea5555389919b0f9648cc1092ae0a6bfc037be2debd6544e5e4cdb803ec'
export ANNOTATION=DCP

if [ "foo$WORK" == "foo" ]
then
  export WORK=${FRACTOGRAFDEV}
fi

# RVM Settings -----------------------------------------------------------------
#
pathmunge "/Users/doug/.rvm/bin"
rvm use default

# AWS Settings -----------------------------------------------------------------
#
export AWS_ACCESS_KEY=AKIAJWQ5ZKZAPNG7D3BA
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export AWS_SECRET_KEY=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
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
export AWS_REGION='us-east-1'

export EC2_HOME=${HOME}/Applications/ec2-api-tools
export AWS_CLOUDWATCH_HOME=${HOME}/Applications/CloudWatch
export AWS_CREDENTIAL_FILE=${AWS_CLOUDWATCH_HOME}/credential-file-path

pathmunge ${EC2_HOME}/bin
pathmunge ${AWS_CLOUDWATCH_HOME}/bin

# Java Settings ----------------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Skipping Java settings until I understand the mac better..."; fi
export JAVA_HOME=`/usr/libexec/java_home`

#export JAVA_ROOT=/cygdrive/c/Progra~1/Java/jdk1.6.0_23
#export JAVA_HOME=${JAVA_ROOT}
#export JAVA_HOME_W32=`/bin/cygpath -m $JAVA_HOME `
#pathmunge ${JAVA_HOME}/bin

# Assault Settings -------------------------------------------------------------
#
#if [ $DEBUG_BASHRC == 1 ]; then echo "Assault settings..."; fi
#export ASSAULT_HOME=${WORK}/assault/release
#pathmunge ${ASSAULT_HOME}/bin

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
#export PGSQL_HOME=/Applications/Postgres93.app/Contents/MacOS
export PGSQL_HOME=/Applications/Postgres.app/Contents/Versions/9.4
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
export CDPATH=${CDPATH}:${COURSERA}

# Baltimore Public Art Commons Settings ----------------------------------------
#
export bpac_secret_key_base='c8d6c70eb92d43ff2597ecd72ce44a0d536ad9e12ff9d040fdba2e399ca0379672b3fc5cd033414f4dcf4c3fe53aa0351c379d895a4b54aae0dd29a9ebda199b'

# PKG_CONFIG_PATH --------------------------------------------------------------

export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig

# Personal Config --------------------------------------------------------------
#
if [ $DEBUG_BASHRC == 1 ]; then echo "Personal config settings..."; fi
pathmunge ${HOME}/.bin after
umask 022
#unset autologout

# Don't auto-complete CVS directories
export FIGNORE='\~:CVS:.class:.o'
export fignore='\~:CVS:.class:.o'

# Tell ack to page output (doesn't work in .ackrc!!?)
export ACK_PAGER='less -R'

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

alias ffh='ssh -F $HOME/.ssh/config-ff'
alias goro="sudo su -"
alias gopg="sudo su - postgres"
alias goaws='ssh -i /Users/doug/Documents/dev/DougPrice.pem ubuntu@ec2-107-22-99-76.compute-1.amazonaws.com'
alias ymstat='ssh fractograf@stg-ym-api-01 "./get_stats.sh"'
alias ustat='ssh fractograf@stg-ym-api-01 "./get_user_stats.sh"'
alias goal='ssh alchemee@dev.solipet.me'
#alias goff='ssh fractograf@dev.solipet.me'
alias goff='ssh ff-dev'
alias goapi='ssh ff-api'
alias gome='ssh dev.solipet.me'

alias psg="ps -ef | grep "
alias ep='echo $PATH | tr ":" "\n" '
alias el='echo $LD_LIBRARY_PATH | tr ":" "\n" '

alias ant="ant notest"

alias run_redis='redis-server /usr/local/etc/redis.conf &'
alias httpd='python -m SimpleHTTPServer 8090'
alias post='curl -X POST -H "Content-Type application/json" '

#alias cvss='cvs status | grep Status'
#alias cvsu="cvs -n update 2>&1 | grep -v 'update' | grep -v 'cvs server'"

alias vi='mvim'

alias androiddebug='adb forward tcp:9222 localabstract:chrome_devtools_remote'

alias gs='git status'
alias gl='git log'

alias rake='bundle exec rake '
alias rr='bundle exec rake routes'
alias rrg='bundle exec rake routes | grep'
#alias ti='bundle exec rake db:test:prepare; bundle exec rake n10n:db:test:prepare; ruby -Itest '
alias cap='time bundle exec cap'

alias tl='tree | less'
alias sql3='sqlite3 db/development.sqlite3'
alias sql3l='sqlite3 -line db/development.sqlite3'

alias bpac='cd ${HOME}/Documents/dev/bpac; rails server -p 4000'
#sudo netstat -ltnp | grep ':80'


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



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# Allows for pulling from the ff production or development DBs. Relies on
# the passwords being set in $HOME/.pgpass.
#
ffpg()
{
  FFDDIR="$HOME/.ff-dumps"
  PGDBNM="fractograf"
  PGUSER="fractograf"
  PGPORT=5432
  PGHOST=

  [ ! -d $FFDDIR ] && mkdir $FFDDIR

  case ${1} in
    "local")
      PGHOST="localhost"
      PGDBNM="ff_dev"
      ;;

    "dev")
      PGHOST="oregon1.ci3oznfwv2lb.us-west-2.rds.amazonaws.com"
      PGDBNM="ff_dev"
      ;;
    "prd")
      PGHOST="ff-v-1-1.cuydb2g2fkq6.us-east-1.rds.amazonaws.com"
      ;;
    *)
      PGDBNM=
      PGHOST=
      printf "\nUsage: ffdb <dev|prd|local>\n\n"
      return 1
      ;;
  esac
}

ffpull()
{
  ffpg ${1}; [ $? != 0 ] && return 1

  PGFILE="${FFDDIR}/${1}-`date +\"%Y%m%d-%H%M%S\"`"

  printf "Host $PGHOST\n  DB $PGDBNM\n  To $PGFILE\n"
  pg_dump --host $PGHOST     --port $PGPORT \
          --username $PGUSER --role $PGUSER \
          --format=d --compress 9           \
          --file "$PGFILE" $PGDBNM

  rm -f $FFDDIR/${1}; ln -s $PGFILE $FFDDIR/${1}
}

ffpush()
{
  if [ ! $# == 2 ];
  then
    printf "Usage: ffpush <local|dev|prd> <local|dev>\n"
    printf "  aka: ffpush from to"
    return 1
  fi

  case ${2} in
    "prd")
      printf "Usage: ffpush <local|dev|prd> <local|dev>\n"
      printf "I seriously doubt you mean to push to production, not doin it.\n"
      return 2
      ;;
  esac

  # Qualify the source param
  #
  ffpg ${1}; [ $? != 0 ] && return 1

  # Qualify the target param
  #
  ffpg ${2}; [ $? != 0 ] && return 1

  PGFILE="${FFDDIR}/${1}/"

  printf "Host $PGHOST\n  DB $PGDBNM\nPush $PGFILE\n"
  pg_restore -c -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDBNM -W $PGFILE
}

# Allows for deployment of a single file to either the production or development instances.
#
ffhosts()
{

  case ${1} in
    "dev")
      PGHOSTS="ff-or-api-setup"
      ;;
    "prd")
      PGHOSTS="ff-www-deploy ff-api-prd-01 ff-api-prd-02 ff-www-prd-01 ff-www-prd-02"
      ;;
    "prd-deploy")
      PGHOSTS="ff-www-deploy"
      ;;
    *)
      PGHOSTS=""
      printf "\nUsage: ffhosts <dev|prd|prd-deploy>\n\n"
      return 1
      ;;
  esac
}

ffdeploy()
{
  if [ $# -lt 3 ];
  then
    printf "Usage: ffdeploy <dev|prd|prd-deploy> <file> <dest_dir> <conf?>\n"
    return 1
  fi
  FFFILE=${2}
  FFDEST=${3}
  FFCONF="false"
  if [ $# -gt 3 ]
  then
    FFCONF=${4}
  fi
  
  ffhosts ${1}; [ $? != 0 ] && return 1

  for host in ${PGHOSTS}
  do
    echo "scp ${FFFILE} ${host}:${FFDEST}"
          scp ${FFFILE} ${host}:${FFDEST}
    if [ "true" == $FFCONF ]
    then
      echo "scp ${FFFILE} ${host}:/ebs/ff_web/conf/fractograf/"
            scp ${FFFILE} ${host}:/ebs/ff_web/conf/fractograf/
    fi
  done
  unset FFFILE
}

ffrun()
{
  if [ $# -lt 2 ];
  then
    printf "Usage: ffrun <dev|prd|prd-deploy> <command>\n"
    return 1
  fi
  CMD=${2}
  
  ffhosts ${1}; [ $? != 0 ] && return 1

  for host in ${PGHOSTS}
  do
    echo "ssh ${host} \"${CMD}\""
          ssh ${host}  "${CMD}"
  done
}

s3deploy()
{
  if [ ! $# == 3 ];
  then
    printf "Usage: ffdeploy <dev|prd> <file> <dest_dir>\n"
    return 1
  fi
  case ${1} in
    "dev")
      S3BUCKET="fractograf-dev"
      ;;
    "prd")
      S3BUCKET="fractograf"
      ;;
    *)
      S3BUCKET=""
      printf "\nUsage: s3deploy <dev|prd> <file> <dest_dir>\n\n"
      return 2
      ;;
  esac
  FFFILE=${2}
  FFDEST=${3}

  aws s3 cp ${FFFILE} s3://${S3BUCKET}/${FFDEST}/${FFFILE} --acl public-read
}

featured_deploy()
{
  if [ $# == 0 ];
  then
    printf "\nUsage: featured_deploy <dev|prd>\n\n"
    return 1
  else
    DEPLOY_ENV=$1
  fi
  if [ $DEPLOY_ENV -eq "prd" ];
  then
    DEPLOY_ENV="prod"
  fi

  git add featured.json.${DEPLOY_ENV};               [ $? != 0 ] && return 1
  git commit -m "updates to ${DEPLOY_ENV} featured"; [ $? != 0 ] && return 1
  git push origin featured;                          [ $? != 0 ] && return 1
  ./featured-${DEPLOY_ENV}-deploy;                   [ $? != 0 ] && return 1
}

# run a test from the application root
ti()
{
  export RAILS_ENV=test
  if [ $# == 0 ];
  then
    printf "\nUsage: ti test/integration/YOUR_TEST_HERE.rb [-n /pattern/]\n\n"
    return 1
  fi
  pushd ${WORK}/ff_web
  bundle exec rake db:test:prepare
  bundle exec rake n10n:db:test:prepare
  echo "ruby -Itest $@"
  ruby -Itest "$@"
  popd
  unset RAILS_ENV
}

