#!/bin/bash 

p () {              
  text=$1
  length=$((${#text} + 26))
  printf "\n"
  for (( i=1; i<=$length; i++ )); do printf "_"; done
  printf "\n\n#   setup.sh   #   $text...   #\n"
  for (( i=1; i<=$length; i++ )); do printf "_"; done
  printf "\n\n"
}

p "Generating your first SSH key"

echo -n "Name for this machine: "
read machine_name
echo -n "Email adress: "
read email_addr
echo -n "SSH key name: "
read ssh_key_name
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/$ssh_key_name -C $email_addr

p "Setting up git & GitHub's CLI with SSH"

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh

gh auth login -s "user:email write:public_key" -w
gh ssh-key add ~/.ssh/$ssh_key_name.pub --title "$machine_name"
gh config set git_protocol ssh

p "Creating temporary directory ~/_tmp for downloads"

mkdir ~/_tmp

p "Adding custom repositories"

sudo add-apt-repository -y ppa:andreasbutti/xournalpp-master
sudo add-apt-repository -y ppa:linrunner/tlp

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
printf "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

p "Installing utilities"

# bat       | syntax highlighted 'cat' command    | https://github.com/sharkdp/bat
# fzf       | command-line fuzzy finder           | https://github.com/junegunn/fzf
# gdebi     | installation tool for .deb files    | https://doc.ubuntu-fr.org/gdebi
# gthumb    | image viewer for GNOME              | https://gitlab.gnome.org/GNOME/gthumb
# htop      | interactive process viewer          | https://github.com/htop-dev/htop
# ncdu      | command-line disk usage analyzer    | https://dev.yorhel.nl/ncdu
# peek      | GIF (& MP4) video screen recorder   | https://github.com/phw/peek
# ag        | (silversearcher-ag) better grep     | https://github.com/ggreer/the_silver_searcher
# xournalpp | PDF editor                          | https://github.com/xournalpp/xournalpp
# zoxide    | smarter 'cd' command based on usage | https://github.com/ajeetdsouza/zoxide
# zsh       | improved shell                      | https://github.com/zsh-users/zsh

sudo apt update \
  && sudo apt install -y bat \
  && sudo apt install -y build-essential \
  && sudo apt install -y fzf \
  && sudo apt install -y gdebi \
  && sudo apt install -y gthumb \
  && sudo apt install -y htop \
  && sudo apt install -y imagemagick \
  && sudo apt install -y jq \
  && sudo apt install -y libavcodec-extra \
  && sudo apt install -y libvips \
  && sudo apt install -y ncdu \
  && sudo apt install -y peek \
  && sudo apt install -y postgresql postgresql-contrib libpq-dev \
  && sudo apt install -y powertop \
  && sudo apt install -y silversearcher-ag \
  && sudo apt install -y spotify-client \
  && sudo apt install -y tmux \
  && sudo apt install -y tree \
  && sudo apt install -y vlc \
  && sudo apt install -y whois \
  && sudo apt install -y xournalpp \
  && sudo apt install -y zsh

curl -sS https://webinstall.dev/zoxide | bash

p "Downloading & installing .deb applications"

wget -O ~/_tmp/discord.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
sudo gdebi --non-interactive ~/_tmp/discord.deb

wget -O ~/_tmp/virtualbox.deb "https://download.virtualbox.org/virtualbox/6.1.26/virtualbox-6.1_6.1.26-145957~Ubuntu~eoan_amd64.deb"
sudo gdebi --non-interactive ~/_tmp/virtualbox.deb

wget -O ~/_tmp/vscode.deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
sudo gdebi --non-interactive ~/_tmp/vscode.deb

p "Installing and launching tlp battery manager"

sudo apt install -y tlp tlp-rdw smartmontools
sudo apt install -y acpi-call-dkms # for Thinkpad T480
sudo tlp start

p "Installing & setting up Ruby"

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
printf '\n# Rbenv configuration\nexport PATH="$HOME/.rbenv/bin:$PATH"\neval "$(rbenv init -)"' >> ~/.zshrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | zsh
source ~/.zshrc

# ruby
sudo apt install -y libssl-dev libreadline-dev
rbenv install 2.7.4
rbenv global 2.7.4

p "Installing Node"

# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | zsh
source ~/.zshrc
nvm install node

# npm
nvm install-latest-npm

p "Installing Oh-My-Zsh"

p "/!\ When ZSH terminal prompts after install, type 'exit' to keep the setup going"

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

p "Installing ZSH plugins"

git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/autoupdate
# git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm

p "Installing PowerLevel10k theme"

mkdir -p ~/.local/share/fonts
wget -O ~/.local/share/fonts/MesloLGS_NF_Regular.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -O ~/.local/share/fonts/MesloLGS_NF_Bold.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -O ~/.local/share/fonts/MesloLGS_NF_Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -O ~/.local/share/fonts/MesloLGS_NF_Bold_Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

p "Copying dotfiles"

cp ~/dotfiles-main/.gitconfig ~/.gitconfig
cp ~/dotfiles-main/.p10k.zsh ~/.p10k.zsh
cp ~/dotfiles-main/.zshrc ~/.zshrc

p "Flushing stuff"

rm ~/dotfiles-main.zip
rm -r ~/_tmp

p "Done! Please close this window, log out, log back in to finalize ZSH install"
