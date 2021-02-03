printf "\n >>>>> Configuring GitHub...\n\n"

# Login on GitHub
gh auth login -s 'user:email' -w

# Switch to SSH
gh config set git_protocol ssh
