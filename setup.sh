printf "\n >>>>> Installing ZSH plugins...\n\n"

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


printf "\n >>>>> Generate SSH key...\n\n"

echo -n "Email adress: "
read email_addr
mkdir -p ~/.ssh && ssh-keygen -t ed25519 -a 100 -f ~/.ssh/id_ed25519 -C $email_addr
