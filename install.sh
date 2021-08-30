#!/bin/bash 

echo ">>> Creating temporary directory ~/_tmp for downloads..."

mkdir ~/_tmp

echo ">>> Adding custom repositories..."

sudo add-apt-repository -y ppa:andreasbutti/xournalpp-master
sudo add-apt-repository -y ppa:dhor/myway
sudo add-apt-repository -y ppa:linrunner/tlp

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

echo ">>> Updating..."

sudo apt update

echo ">>> Downloading utilities..."

wget -O ~/_tmp/discord.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
wget -O ~/_tmp/virtualbox.deb "https://download.virtualbox.org/virtualbox/6.1.14/virtualbox-6.1_6.1.14-140239~Ubuntu~eoan_amd64.deb"
wget -O ~/_tmp/vscode.deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"

echo ">>> Installing utilities..."

sudo apt install -y \
  bat \
  build-essential \
  gh \
  gthumb \
  htop \
  imagemagick \
  jq \
  libavcodec-extra \
  libvips
  ncdu \
  peek \
  postgresql postgresql-contrib libpq-dev \
  powertop \
  silversearcher-ag \
  spotify-client \
  tmux \
  tree \
  vlc \
  whois \
  xournalpp \
  zsh

sudo apt install -y ~/_tmp/discord.deb
sudo apt install -y ~/_tmp/virtualbox.deb
sudo apt install -y ~/_tmp/vscode.deb

echo ">>> Installing and launching tlp battery manager..."

sudo apt install -y tlp tlp-rdw smartmontools
sudo apt install -y acpi-call-dkms # for Thinkpad T480
sudo tlp start

echo ">>> Installing & setting up Ruby..."

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo '\n# Rbenv configuration\nexport PATH="$HOME/.rbenv/bin:$PATH"\neval "$(rbenv init -)"' >> ~/.zshrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# ruby
sudo apt install -y libssl-dev libreadline-dev
rbenv install 2.7.4
rbenv global 2.7.4

echo ">>> Installing Node..."

# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | zsh
nvm install node

# npm
nvm install-latest-npm

echo ">>> Installing Oh-My-Zsh..."
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
