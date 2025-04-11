```sh
sudo apt update && sudo apt upgrade -y
sudo apt install build-essential unzip xsel ripgrep
```

```sh
# Bun.js
curl -fsSL https://bun.sh/install | bash
bun add --global wsl-open
```

```sh
# Volta and Node.js
curl https://get.volta.sh | bash
volta install node
```

```sh
# Prettier
volta install prettier
```

```sh
# Git setup
git config --global user.name $
git config --global user.email $
```

```sh
# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> $HOME/.bashrc
git clone git@github.com:smdhnz/nvim.git $HOME/.config/nvim
```

```sh
# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz lazygit
```

```sh
# Docker
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh
sudo gpasswd -a $USER docker
sudo service docker restart
```

```sh
# aliases
alias vi="nvim"
alias vim="nvim"
alias clip="xsel -bi"
alias open="wsl-open"

# functions
function activate () {
  local dir="$PWD"

  # .venv を含むディレクトリを上へ辿って探す
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/.venv/bin/activate" ]; then
      source "$dir/.venv/bin/activate"
      return
    fi
    dir=$(dirname "$dir")
  done

  # 見つからなければカレントディレクトリに新しく作成
  python3 -m venv --without-pip .venv &> /dev/null && \
  source .venv/bin/activate &> /dev/null && \
  curl -LO https://bootstrap.pypa.io/get-pip.py &> /dev/null && \
  python3 get-pip.py &> /dev/null && \
  rm get-pip.py &> /dev/null && \
  pip install isort black &> /dev/null
}


EXCLUDED_DIRS=("__pycache__" "node_modules" "dist")
all-cat() {
  local target_dir="$1"
  shift
  local exts=("$@")
  if [[ -z "$target_dir" || "${#exts[@]}" -eq 0 ]]; then
    echo "使い方: all-cat <検索ディレクトリ> <拡張子1> [拡張子2] ..."
    echo "例: all-cat . py js ts"
    return 1
  fi
  # 除外条件を find の -path 条件に変換
  local exclude_args=()
  for dir in "${EXCLUDED_DIRS[@]}"; do
    exclude_args+=(! -path "*/$dir/*")
  done
  # 各拡張子についてファイル検索と出力
  for ext in "${exts[@]}"; do
    find "$target_dir" -type f -name "*.${ext}" "${exclude_args[@]}" | while read -r file; do
      echo "[${file}]"
      echo "\`\`\`${ext}"
      cat "$file"
      echo "\`\`\`"
      echo ""
    done
  done
}
```
