# Versioned Dotfiles


## Computer Set Up

All steps to get a new machine up and running, assuming MX Linux XFCE.

### Download ISO and Install

Follow latest instructions to burn the iso to a USB and install

### Notes for XPS

In MX Tweak, Other, set "Use Intel driver instead of default modesetting..."

This gives better performance with dual monitors.


### Install zsh and Tweaks to Shell

First change root user:

* `sudo -s` followed by `chsh -s /bin/zsh root`

Now the user:

* `chsh -s /bin/zsh` 

* install oh-my-zsh 

Rofi:

`sudo pacman -S rofi` and then bind `rofi -show drun` to `Alt d` in keyboard shortcuts

Terminal:

* Install kitty

### Set Up Dotfiles

Download dotfiles and use GNU stow (`sudo pacman -S stow`)

* example: `cd dotfiles` and then `stow zsh`  

### Install Basic Software

* install latex, git

### Install and Set Fonts

Install Nerd Fonts via AUR

### Configure XFCE

* set keyboard shortcuts in keyboard -> applications shortcuts

  - Alt-Enter for kitty or xfce-terminal

* set keyboard shortcuts in window manager

  - Alt-m maximizes
  - Alt-r resize
  - Alt-k closes
  - Alt-f fullscreen

* Use "windown manager tweaks" to turn of wrapping of workspaces

### Screen lock

Install `sudo apt install suckless-tools`, execute on command line, password to exit


### Set Up Neovim

Use package manager to install neovim, python3-neovim

* `pip install neovim`

* follow instructions to install and set up `vim-plug` from junegunn

* Run `:PlugInstall` 



### SSH

To generate a key, use

* `ssh-keygen -t rsa` and then your ssh passphrase

Now `ssh-add` when you start your machine.  To copy it to the server, use

* `ssh-copy-id -i ~/.ssh/mykey user@host`


### Versioned Tools

* `cd ~` and `git clone https://github.com/jstac/versioned_tools`, then add symbolic links in `bin`

* make the dir `~/texmf/bibtex/bst` and add ecta.bst, etc., and then do `texhash ~/texmf`, check with `kpsewhich ecta.bst`

### GH Credentials

https://docs.github.com/en/github/extending-github/git-automation-with-oauth-tokens

See comments there about caching credentials.


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

