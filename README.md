# versioned_dotfiles


## Install steps

* install latex, anaconda, julia, zsh, git, neovim, python-neovim

* `chsh -s /bin/zsh` 

* install oh-my-zsh via `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` or similar

* set keyboard shortcuts in launcher 

  - Alt-Enter for xfce4-terminal

* set keyboard shortcuts in window manager

  - Alt-c cycles
  - Alt-m maximizes
  - Alt-k closes
  - Alt-f fullscreen

* install chrome (e.g, https://linuxconfig.org/how-to-install-google-chrome-on-manjaro-18-linux or `yaourt -S google-chrome`)

* `ln -s versioned_dotfiles/.zshrc .`
* `ln -s versioned_dotfiles/.latexmkrc .`
* `ln -s versioned_dotfiles/.vimrc .`
* `ln -s versioned_dotfiles/.ssh/config .`  from inside `~/.ssh`
* `ln -s versioned_dotfiles/.Xmodmap .`   # maps CAPS to CTRL

* cd to `~/.config/nvim/` and type `ln -s ~/versioned_dotfiles/.config/nvim/init.vim .`

* `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

* got to `https://github.com/arcticicestudio/nord-xfce-terminal` and follow instructions

* `jupyter notebook --generate-config` and set browser to firefox

* `ipython profile create`

* `sudo pacman -S rofi` and then bind `rofi -show drun` to `Alt d` in keyboard shortcuts

* ssh keys: see https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

* `cd ~` and `git clone https://github.com/jstac/versioned_tools`, then add symbolic links in `bin`

* make the dir `~/texmf/bibtex/bst` and add ecta.bst, etc., and then do `texhash ~/texmf`, check with `kpsewhich ecta.bst`

* `pip install neovim` seems to be necessary (after installing neovim through pacman)


## Other tips


* Useful discussion regarding default applications: https://www.reddit.com/r/linuxquestions/comments/5z3n81/default_applications_in_arch_linux/

* For vim with system paste support: http://vim.wikia.com/wiki/Accessing_the_system_clipboard



