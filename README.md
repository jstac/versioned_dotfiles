# versioned_dotfiles


## Install steps

* install latex, anaconda, julia, zsh, git

* `chsh -s /bin/zsh` 

* install oh-my-zsh via `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` or similar

* `yaourt -S google-chrome`

* `ln -s versioned_dotfiles/.Xmodmap .`  # maps CAPS to CTRL

* `ln -s versioned_dotfiles/.zshrc .`
* `ln -s versioned_dotfiles/.vimrc .`


* curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

* `ssh-keygen -t rsa -b 4096 -C "john.stachurski@gmail.com" ` and follow remaining steps on https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

* add `pullsync.py` etc to `bin` and then add dir `home/john/backups/sync_dir_backup`

* map `synclient TouchpadOff=0` to `Ctrl-Super-Right` and `=1` to `Left`


## Other tips

* for vim, with system paste support: http://vim.wikia.com/wiki/Accessing_the_system_clipboard



