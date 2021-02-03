echo "Creating temporary directory ~/_tmp for downloads..."
mkdir ~/_tmp


echo "Adding custom repositories..."

## GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages

## Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

## tlp
sudo add-apt-repository ppa:linrunner/tlp

echo "Updating..."
sudo apt update


echo "Downloading utilities..."

## Discord 0.0.13
wget -O ~/_tmp/discord.deb "https://dl.discordapp.net/apps/linux/0.0.13/discord-0.0.13.deb"

## VirtualBox 6.1.14
wget -O ~/_tmp/virtualbox.deb "https://download.virtualbox.org/virtualbox/6.1.14/virtualbox-6.1_6.1.14-140239~Ubuntu~eoan_amd64.deb"

## Visual Studio Code
wget -O ~/_tmp/vscode.deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"


echo "Installing utilities..."
sudo apt install \
  ~/_tmp/discord.deb
  gh # GitHub CLI
  htop
  powertop
  silversearcher-ag # A better grep
  spotify-client
  ~/_tmp/virtualbox.deb
  vlc
  ~/_tmp/vscode.deb
  zsh

echo "Installing tlp battery manager..."

sudo apt install tlp tlp-rdw smartmontools
sudo apt install acpi-call-dkms # for Thinkpad T480
sudo tlp start

echo "Installing Oh-My-Zsh and plugins..."

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Visit https://extensions.gnome.org/extension/307/dash-to-dock/ to customize Dock!"
