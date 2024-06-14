```sh
$ curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

$ chmod u+x nvim.appimage

$ mkdir -p $HOME/.appimage/neovim/; mv nvim.appimage $_

$ echo 'alias vim="$HOME/.appimage/neovim/nvim.appimage"' >> $HOME/.bashrc
$ echo 'alias nvim="$HOME/.appimage/neovim/nvim.appimage"' >> $HOME/.bashrc

$ git clone https://github.com/smdhnz/init.lua.git $HOME/.config/nvim
```
