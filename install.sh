printf "\n >>>>> Creating temporary directory ~/_tmp for downloads...\n\n"
mkdir ~/_tmp


printf "\n >>>>> Adding custom repositories...\n\n"

## GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository -y https://cli.github.com/packages

## Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

## tlp
sudo add-apt-repository -y ppa:linrunner/tlp

printf "\n >>>>> Updating...\n\n"
sudo apt update


printf "\n >>>>> Downloading utilities...\n\n"

## Discord 0.0.13
wget -O ~/_tmp/discord.deb "https://dl.discordapp.net/apps/linux/0.0.13/discord-0.0.13.deb"

## VirtualBox 6.1.14
wget -O ~/_tmp/virtualbox.deb "https://download.virtualbox.org/virtualbox/6.1.14/virtualbox-6.1_6.1.14-140239~Ubuntu~eoan_amd64.deb"

## Visual Studio Code
wget -O ~/_tmp/vscode.deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"


printf "\n >>>>> Installing utilities...\n\n"
sudo apt install -y \
  gh \
  htop \
  powertop \
  silversearcher-ag \
  spotify-client \
  vlc \
  zsh

sudo apt install -y ~/_tmp/discord.deb
sudo apt install -y ~/_tmp/virtualbox.deb
sudo apt install -y ~/_tmp/vscode.deb
  
printf "\n >>>>> Installing and launching tlp battery manager...\n\n"

sudo apt install -y tlp tlp-rdw smartmontools
sudo apt install -y acpi-call-dkms # for Thinkpad T480
sudo tlp start

printf "\n >>>>> Installing Oh-My-Zsh...\n\n"

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

printf "\n >>>>> Visit https://extensions.gnome.org/extension/307/dash-to-dock/ to customize Dock!\n"
