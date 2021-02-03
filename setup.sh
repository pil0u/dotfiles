printf "\n >>>>> Making CTRL+Backspace as backward-kill-word in ZSH...\n\n"

bindkey '^H' backward-kill-word

printf "\n >>>>> Installing ZSH plugins...\n\n"

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

printf "\n >>>>> Installing PowerLevel10k associated font...\n\n"

mkdir -p ~/.local/share/fonts
wget -O ~/.local/share/fonts/MesloLGS_NF_Regular.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
wget -O ~/.local/share/fonts/MesloLGS_NF_Bold.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
wget -O ~/.local/share/fonts/MesloLGS_NF_Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
wget -O ~/.local/share/fonts/MesloLGS_NF_Bold_Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"

echo "WARNING! Please change font settings in GNOME: 

printf "\n >>>>> Generating SSH key...\n\n"

echo -n "Email adress: "
read email_addr
mkdir -p ~/.ssh && ssh-keygen -t ed25519 -a 100 -f ~/.ssh/id_ed25519 -C $email_addr
