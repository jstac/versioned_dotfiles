# versioned_dotfiles


## Install steps

* install latex, anaconda, julia, zsh, git

* `chsh -s /bin/zsh` 

* install oh-my-zsh via `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` or similar

* `yaourt -S google-chrome` and `sudo pacman -S firefox`

* `ln -s versioned_dotfiles/.zshrc .`
* `ln -s versioned_dotfiles/.latexmkrc .`
* `ln -s versioned_dotfiles/.vimrc .`
* `ln -s versioned_dotfiles/.ssh/config .`  from inside `~/.ssh`
* `ln -s versioned_dotfiles/.xprofile .`
* `ln -s versioned_dotfiles/.Xdefaults .`
* `ln -s versioned_dotfiles/.Xmodmap .`   # maps CAPS to CTRL
* `ln -s ~/versioned_dotfiles/.i3_config .` from inside `.i3` directory

* `jupyter notebook --generate-config` and set browser to firefox

* `ipython profile create`

* `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

* `ssh-keygen`  

* add `pullsync.py` etc to `bin` and then add dir `home/john/backups/sync_dir_backup`

* `xdg-mime default zathura.desktop application/pdf`

* make the dir `~/texmf/bibtex/bst` and add ecta.bst, etc., and then do `texhash ~/texmf`, check with `kpsewhich ecta.bst`



## Other tips


* Useful discussion regarding default applications: https://www.reddit.com/r/linuxquestions/comments/5z3n81/default_applications_in_arch_linux/

* For vim with system paste support: http://vim.wikia.com/wiki/Accessing_the_system_clipboard



