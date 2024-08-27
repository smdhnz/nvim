# First setup
sudo apt update && sudo apt upgrade -y

sudo apt install build-essential unzip xsel
echo 'alias clip="xsel -bi"' >> $HOME/.bashrc

# bun
curl -fsSL https://bun.sh/install | bash

bun add --global \
  @fsouza/prettierd \
  wsl-open \
  typescript typescript-language-server \
  @tailwindcss/language-server
echo 'alias open="wsl-open"' >> $HOME/.bashrc

# Volta and Node.js
curl https://get.volta.sh | bash
volta install node

# Git setup
git config --global user.name $
git config --global user.email $
git clone git@github.com:smdhnz/nvim.git $HOME/.config/nvim

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> $HOME/.bashrc

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz lazygit
