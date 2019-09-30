# versioned_dotfiles


## Install steps

* install latex, anaconda, julia, zsh, git, neovim, python-neovim

* `chsh -s /bin/zsh` 

* install oh-my-zsh via `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` or similar

* set keyboard shortcuts in keyboard -> applications shortcuts

  - Alt-Enter for xfce4-terminal

* set keyboard shortcuts in window manager

  - Alt-m maximizes
  - Alt-v maximizes vertically
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

    - also, https://www.ssh.com/ssh/copy-id

* `cd ~` and `git clone https://github.com/jstac/versioned_tools`, then add symbolic links in `bin`

* make the dir `~/texmf/bibtex/bst` and add ecta.bst, etc., and then do `texhash ~/texmf`, check with `kpsewhich ecta.bst`

* sometimes need `pip install neovim`

### For Japanese

Just use Google's Japanese input

Or see https://confluence.jaytaala.com/display/TKB/Japanese+input+with+i3+and+Arch+based+distros


### Notes on AWS


#### To get an instance running

1. Login to Amazon AWS Console 
2. Navigate to EC2 Service
3. Choose your region for setting up an instance
6. Create security key-pair for the region if you don't have one
4. Launch & Configure an instance and choose Ubuntu 64-bit
5. enable access through Port 8000 (in addition to Port 22 for ssh)
6. Choose security key you've set up

#### Connecting and set up 

Use `ssh -i /path/to/pem-key ubuntu@hostname`

Here `hostname` is your Public DNS, as shown in the instance information from AWS console

Now run `sudo apt-get update` so you can install things you might need using `apt-get`


#### Configure instance to run Jupyter

1. ssh into the running instance using IP from AWS Console
2. Install Anaconda using wget and the latest download link for python36
3. Run: jupyter notebook --generate-config
4. For Automatic Password Setup run: jupyter notebook password
5. Edit .jupyter/jupyter_notebook_config.py and set the following

```
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8000 
```

(Previously we set ip to '*' to bind on all interfaces (ips) for the public server but this seems to be broken right now, the above is a fix.)

