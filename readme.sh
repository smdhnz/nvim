# First setup
sudo apt update && sudo apt upgrade -y

sudo apt install build-essential unzip xsel

curl -fsSL https://bun.sh/install | bash

bun add --global wsl-open

# Volta and Node.js
curl https://get.volta.sh | bash
volta install node

# Git setup
git config --global user.name $
git config --global user.email $

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> $HOME/.bashrc
git clone git@github.com:smdhnz/nvim.git $HOME/.config/nvim

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz lazygit

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh
sudo gpasswd -a $USER docker
sudo service docker restart

# .bashrc
# aliases
alias vi="nvim"
alias vim="nvim"
alias clip="xsel -bi"
alias open="wsl-open"

# functions
function activate () {
  if [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
  else
    python3 -m venv --without-pip .venv &> /dev/null && \
    source .venv/bin/activate &> /dev/null && \
    curl -LO https://bootstrap.pypa.io/get-pip.py &> /dev/null && \
    python3 get-pip.py &> /dev/null && \
    rm get-pip.py &> /dev/null && \
    pip install isort black &> /dev/null
  fi
}
