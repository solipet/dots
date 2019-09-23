#! /bin/bash

#
echo "TODO: download and install Dropbox from https://www.dropbox.com/install"

# Download and set up 1Password
#
echo "TODO: download and install 1Password from https://agilebits.com/downloads"

# Download and configure Adium
#
echo "TODO: download and install Adium from https://adium.im/"

# Download and configure MenuMeters
#
echo "TODO: download and install MenuMeters from http://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/"

# Download and configure SizeUp
#
echo "TODO: download and install SizeUp from http://www.irradiatedsoftware.com/sizeup/"

# Download and configure Postgres.app
#
echo "TODO: download and install Postgres.app from http://postgresapp.com/"
echo "      or install via: homebrew install postgresql"

# Download and configure Redis.app
#
echo "TODO: download and install Redis.app from http://jpadilla.github.io/redisapp/"
echo "      or install via: homebrew install redis"


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
BREWS="ack awscli bash ctags dos2unix git gpg graphviz imagemagick jq python3 readline tmux tree wget"
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

# Install rvm and some rubies
#
echo; echo
echo "    installing rvm"
RUBIES="2.5.5 2.6.0"
DEFAULT_RUBY="2.5.5"
RAILS="5.2.1"
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
if [ ! -h ${HOME}/.bashrc ]
then
  echo "    linking .bashrc"
  ln -s ${DOTS_MAC_DIR}/.commonrc .bashrc
else
  echo "    .bashrc already linked"
fi

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

