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

# Download and configure Postgres.app
#
echo "TODO: download and install Postgres.app from http://postgresapp.com/"


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
BREWS="ack bash ctags dos2unix gpg tmux tree graphviz"
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
# so is redis
if [ ! -h /usr/local/bin/redis-cli ]
then
  echo "    installing redis"
  brew install redis
else
  echo "    redis already installed"
fi

# Install rvm and some rubies
#
echo "    installing rvm"
RUBIES="2.3.1"
DEFAULT_RUBY="2.3.1"
RAILS="4.2.5.1"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
for RUBY in ${RUBIES}; do
  if [ ! -e ${HOME}/.rvm/rubies/ruby-${RUBY} ]
  then
    echo "    installing ruby ${RUBY}"
    rvm install ${RUBY}
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
for DOT in ${DOTS}; do
  if [ ! -h ${HOME}/${DOT} ]
  then
    echo "    linking ${DOT}"
    ln -s ${DOTS_DIR}/${DOT}
  else
    echo "    ${DOT} already linked"
  fi
done
if [ ! -h ${HOME}/.bashrc ]
then
  echo "    linking .bashrc"
  ln -s Documents/dev/dots/mac/.commonrc .bashrc
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
  cp ${HOME}/Documents/dev/dots/mac/.projects/default ${HOME}/.projects
  cp ${HOME}/Documents/dev/dots/mac/.projects/available/sample.conf ${HOME}/.projects/available
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
  git clone https://github.com/ctrlpvim/ctrlp.vim.git
  git clone git://github.com/tpope/vim-bundler.git
  git clone git://github.com/tpope/vim-rails.git
  git clone --depth=1 https://github.com/scrooloose/syntastic.git
else
  echo "appears that vim is already configured"
fi

# Create ${HOME}/.bin for personal scripts on the PATH
if [ ! -d ${HOME}/.bin ]
then
  echo "creating ${HOME}/.bin"
  mkdir ${HOME}/.bin
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

