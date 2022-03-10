# Versioned Dotfiles


## Computer Set Up

All steps to get a new machine up and running, assuming Ubuntu flavor

## Examine your set up

* `inxi -Gxx` gives information on your graphics drivers

(On XPS, Device-1 Intel uses driver: i915, Device-2 uses driver: nvidia v: 510.47.03)

### Install zsh and Tweaks to Shell

First change root user:

* `sudo -s` followed by `chsh -s /bin/zsh root`

Now the user:

* `chsh -s /bin/zsh` 

* install oh-my-zsh 

Rofi:

`sudo pacman -S rofi` and then bind `rofi -show drun` to `Alt d` in keyboard shortcuts


### Set Up Dotfiles

Do the obvious

### Map Caps to CTRL

The remap is in `.profile` and consider `ln -s .profile .xprofile`

The command is `setxkbmap -option "ctrl:nocaps"` 

### Set Up Neovim 

* follow instructions to install and set up `vim-plug` from junegunn
* `pip install pynvim` or `pip install neovim`
* Run `:PlugInstall` 

### Tailscale 

Follow website instructions and install via apt

### Anaconda

Install as usual.  Create configs with 

* `jupyter notebook --generate-config`  (set browser to `chomium`)
* `ipython profile create`

### Install Basic Software

* install latex, git, etc.

### Install and Set Fonts

Install Nerd Fonts 

### Configure keyboard shortcuts

To be added

### Screen lock

Install `sudo apt install suckless-tools`, execute on command line, password to exit

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

`git config --global credential.helper "cache --timeout=864000"`  # 10 days


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

