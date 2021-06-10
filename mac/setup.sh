#! /bin/bash

#
echo "TODO: download and install Dropbox from https://www.dropbox.com/install"

# Download and set up 1Password
#
echo "TODO: download and install 1Password from https://agilebits.com/downloads"

# Download and configure MenuMeters
#
echo "TODO: download and install MenuMeters from http://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/"

# Download and configure SizeUp
#
echo "TODO: download and install SizeUp from http://www.irradiatedsoftware.com/sizeup/"

# Download and configure iTerm2
#
echo "TODO: download and install iTerm2 from https://iterm2.com"

# Download and configure RubyMine
#
echo "TODO: download and install RubyMine from https://www.jetbrains.com/ruby/download/#section=mac"

# Download and configure Postgres.app
#
echo "TODO: download and install Postgres.app from http://postgresapp.com/"
echo "      or install via: homebrew install postgresql"

# Download and configure Redis.app
#
echo "TODO: download and install Redis.app from http://jpadilla.github.io/redisapp/"
echo "      or install via: homebrew install redis"

sleep1
echo; echo

# Set up non-work dev environment
#
echo "configuring environment"
if [ ! -d ${HOME}/Documents/dev/dots ]
then
  mkdir -p ~/Documents/dev
  cd ~/Documents/dev
  git clone git@bitbucket.org:dcprice/dots.git
fi
cd ${HOME}
DOTS=".ackrc .aliases .bash_profile .bash_prompt .commonrc .functions .vimrc"
DOTS_DIR="${HOME}/Documents/dev/dots"
DOTS_MAC_DIR="${HOME}/Documents/dev/dots/mac"
for DOT in ${DOTS}; do
  if [ ! -h ${HOME}/${DOT} ]
  then
    echo "    linking ${DOT}"
    ln -s ${DOTS_MAC_DIR}/${DOT}
  else
    echo "    ${DOT} already linked"
  fi
done

if [[ -h ${HOME}/.bashrc ]]
then
  echo -n "    .bashrc exists! type YES to remove it and start clean (anything else will leave it alone): "
  read remove
  if [[ $remove = "YES" ]]
  then
    echo "        removing existing .bashrc..."
    rm -f ~/.bashrc
  else
    echo "        not removing .bashrc... carry on!"
  fi
fi

if [ ! -h ${HOME}/.bashrc ]
then
  echo "    linking .bashrc"
  ln -s ${DOTS_MAC_DIR}/.commonrc .bashrc
else
  echo "    .bashrc already linked"
fi

# Load the environment
source ~/.bashrc


# Install homebrew
#
if [ ! -e /usr/local/Homebrew/bin/brew ]
then
  echo "installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "homebrew already installed"
fi

# Install brews
#
echo "installing brews"
BREWS="ack awscli bash ctags dos2unix git gpg graphviz imagemagick jq postgresql python3 readline redis tmux tree wget"
for BREW in ${BREWS}; do
  if [ ! -h /usr/local/bin/$BREW ]
  then
    echo "    installing $BREW"
    brew install $BREW
  else
    echo "    $BREW already installed"
  fi
done
# macvim is special
if [ ! -h /usr/local/bin/mvim ]
then
  echo "    installing macvim"
  brew install macvim
else
  echo "    macvim already installed"
fi
# # so is redis
# if [ ! -h /usr/local/bin/redis-cli ]
# then
#   echo "    installing redis"
#   brew install redis
# else
#   echo "    redis already installed"
# fi

# Start PostgreSQL and Redis
brew service start postgresql
brew service start redis

# Install rvm and some rubies
#
echo; echo
echo "    installing rvm"
echo "        if this fails to install ruby due to a problem in libffi, come back and uncomment the some variables to use"
# export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
RUBIES="2.6.5 2.7.3"
DEFAULT_RUBY="2.6.5"
RAILS="6.1.3"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
for RUBY in ${RUBIES}; do
  if [ ! -e ${HOME}/.rvm/rubies/ruby-${RUBY} ]
  then
    echo "    installing ruby ${RUBY}"
    rvm install ${RUBY}
    rvm use ${RUBY}
    echo "      installing nokogiri"
    nokogiri_install = "do gem install nokogiri"
    rvm @global ${nokogiri_install}
  else
    echo "    ruby ${RUBY} already installed"
  fi
done
rvm default use ${DEFAULT_RUBY}
if [ ${RAILS} ]
then
  echo "    installing rails ${RAILS}"
  gem install rails -v ${RAILS}
else
  echo "    skip the install on rails for now"
fi

echo; echo

# Install nvm and some nodes
#
echo; echo
echo "    installing nvm"
NODES="12.13.1"
DEFAULT_NODE="12.13.1"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
for NODE in ${NODEs}; do
  if [ ! -e ${HOME}/.nvm/versions/node/v${NODE} ]
  then
    echo "    installing node ${NODE}"
    nvm install ${NODE}
    nvm use ${RUBY}
  else
    echo "    node ${NODE} already installed"
  fi
done
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm alias default ${DEFAULT_NODE}

echo; echo

# Install awslogs
# https://github.com/jorgebastida/awslogs
echo "    installing awslogs"
pip install awslogs

# Install aws-cft
# https://github.com/USSBA/aws-cft-tools
cd ~/Documents/dev
git clone git@github.com:USSBA/aws-cft-tools
cd aws-cft-tools
bundle install
bundle exec rake install

# Set up work environment
#
if [ ! -d ${HOME}/.projects ]
then
  echo "configuring work environment"
  mkdir -p ${HOME}/.projects/available
  mkdir -p ${HOME}/.projects/enabled
  cp ${DOTS_MAC_DIR}/.projects/default ${HOME}/.projects
  cp ${DOTS_MAC_DIR}/.projects/available/sample.conf ${HOME}/.projects/available
  echo "******* Need to set up .projects/available configs ********"
else
  echo "appears that the work projects are already configured"
fi

# Set up vim color scheme
if [ ! -d ${HOME}/.vim/colors/solipet.vim ]
then
  mkdir -p ~/.vim/colors
  cd ~/.vim/colors
  ln -s ${DOTS_MAC_DIR}/.vim/colors/solipet.vim
else
  echo "appears that vim color scheme is already configured"
fi

# Set up vim with pathogen and various bundles
#
if [ ! -d ${HOME}/.vim/bundle ]
then
  echo "configuring vim with pathogen"
  mkdir -p ${HOME}/.vim/autoload ${HOME}/.vim/bundle && \
  curl -LSso ${HOME}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  cd ${HOME}/.vim/bundle
  git clone https://github.com/w0rp/ale.git
  git clone https://github.com/ctrlpvim/ctrlp.vim.git
  git clone https://github.com/keith/rspec.vim.git
  git clone git://github.com/tpope/vim-bundler.git
  git clone https://github.com/tpope/vim-fugitive.git
  git clone git://github.com/airblade/vim-gitgutter.git
  git clone git://github.com/tpope/vim-rails.git
  git clone https://github.com/skwp/vim-rspec.git
  git clone git://github.com/slim-template/vim-slim.git
  # git clone --depth=1 https://github.com/scrooloose/syntastic.git
else
  echo "appears that vim is already configured"
fi

# Create ${HOME}/.bin for personal scripts on the PATH
if [ ! -d ${HOME}/.bin ]
then
  echo "linking ${HOME}/.bin"
  ln -s ${DOTS_DIR}/.bin ${HOME}/.bin
else
  echo "${HOME}/.bin dir already exists"
fi

# Install git tar
if [ ! -f ${HOME}/.bin/git-tar ]
then
  echo "installing git-tar"
  curl -LSso ${HOME}/.bin/git-tar https://github.com/jphelps413/git-tar/blob/master/git-tar
  chmod 555 ${HOME}/.bin/git-tar
else
  echo "git-tar already installed"
fi

