# Versioned Dotfiles


## Computer Set Up

All steps to get a new machine up and running, assuming Manjaro XFCE.


### Download ISO and Install

Get ISO and then

* `sudo fdisk -l` to find which device --- usually `/dev/sdb/`

* `sudo umount /dev/sdb` and then `sudo dd if=/path/to/iso of=/dev/sdb bs=1M`


### Install zsh and Tweaks to Shell

First change root user:

* `sudo -s` followed by `chsh -s /bin/zsh root`

Now the user:

* `chsh -s /bin/zsh` 

* install oh-my-zsh via `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` or similar

* `sudo pacman -S exa` (modern replacement for ls)

Colors:

* got to `https://github.com/arcticicestudio/nord-xfce-terminal` and follow instructions

### Set Up Dotfiles

In home dir

* `ln -s gh_synced/versioned_dotfiles/.zshrc .`
* `ln -s gh_synced/versioned_dotfiles/.latexmkrc .`
* `ln -s gh_synced/versioned_dotfiles/.vimrc .`
* `ln -s gh_synced/versioned_dotfiles/.Xmodmap .`   # maps CAPS to CTRL

From inside `~/.ssh`

* `ln -s gh_synced/versioned_dotfiles/.ssh/config .`  

From inside `~/.config/nvim/` 

* `ln -s ~/versioned_dotfiles/.config/nvim/init.vim .`


### Install Basic Software

* install latex, zsh, git

* install chrome --- google for latest terminal method

### Install and Set Fonts

Caskaydia Cove Nerd font via AUR

* `yay -S nerd-font-cascadia-code`

Now select this font for terminal by GUI, in preferences 
(seems to have different spelling)


### Configure XFCE

* set keyboard shortcuts in keyboard -> applications shortcuts

  - Alt-Enter for xfce4-terminal

* set keyboard shortcuts in window manager

  - Alt-m maximizes
  - Alt-v maximizes vertically
  - Alt-k closes
  - Alt-f fullscreen

* Use "windown manager tweaks" to turn of wrapping of workspaces


### Anaconda / Jupyter / IPython

Get Anaconda and then

* `jupyter notebook --generate-config` and set browser to firefox

* `ipython profile create`

* `sudo pacman -S rofi` and then bind `rofi -show drun` to `Alt d` in keyboard shortcuts


### Set Up Editor

Install neovim, python-neovim

Install npm and nodejs via yay

* follow instructions to install and set up `vim-plug` from junegunn

* Run `:PlugInstall` and then `:CocInstall xyz` as per vimrc

* sometimes need `pip install --upgrade neovim`


### SSH

To generate a key, use

* `ssh-keygen -t rsa` and then your ssh passphrase

Now `ssh-add` when you start your machine.  To copy it to the server, use

* `ssh-copy-id -i ~/.ssh/mykey user@host`


### Versioned Tools

* `cd ~` and `git clone https://github.com/jstac/versioned_tools`, then add symbolic links in `bin`

* make the dir `~/texmf/bibtex/bst` and add ecta.bst, etc., and then do `texhash ~/texmf`, check with `kpsewhich ecta.bst`



## For Japanese

Just use Google's Japanese input

Or see https://confluence.jaytaala.com/display/TKB/Japanese+input+with+i3+and+Arch+based+distros


## Notes on AWS


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

