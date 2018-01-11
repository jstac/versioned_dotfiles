# versioned_dotfiles


## Install steps

* install latex, anaconda, julia, zsh, git

* `chsh -s /bin/zsh` 

* install oh-my-zsh via `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` or similar

* `yaourt -S google-chrome`

* `ln -s versioned_dotfiles/.Xmodmap .`  # maps CAPS to CTRL

* `ln -s versioned_dotfiles/.zshrc .`
* `ln -s versioned_dotfiles/.vimrc .`
* `ln -s ~/versioned_dotfiles/.i3_config .` from inside `.i3` directory


* curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

* `ssh-keygen`  

* add `pullsync.py` etc to `bin` and then add dir `home/john/backups/sync_dir_backup`

* map `synclient TouchpadOff=0` to `Ctrl-Super-Right` and `=1` to `Left`


## Other tips

* for vim, with system paste support: http://vim.wikia.com/wiki/Accessing_the_system_clipboard



