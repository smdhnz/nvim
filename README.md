```sh
$ curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

$ chmod u+x nvim.appimage

$ mkdir -p /opt/nvim
$ mv nvim.appimage /opt/nvim/nvim

$ echo 'export PATH="$PATH:/opt/nvim/"' >> $HOME/.bashrc

$ git clone https://github.com/smdhnz/nvim.git $HOME/.config/nvim
```
