# Versioned Dotfiles

See also `install_log.txt`, which automates some of these steps

## Computer Set Up

Install latest Ubuntu via apt.

## Wayland

Disable Wayland by editing `/etc/gdm3/custom.conf` and uncommenting `WaylandEnable=false`

It messes with rofi and GPU set up.

## Dotfiles

Clone `versioned_dotfiles`

The following steps are detailed in `install_log.txt`.  Here is the outline:

* files in `top_level` should be linked to from `~`
* files `dot_config/zsh` should be linked to from `.config/zsh`
* other folders in `dot_config/xxx` should be linked to from `.config/xxx`


## Neovim

Note that treesitter often has problems after install.  Try
`:TSUpdate`
`:TSInstall vim`
`:TSInstall latex`
`:TSInstall julia`

Sometimes treesitter wants to you install tree-sitter-cli.

I followed these instructions

* https://linuxize.com/post/how-to-install-node-js-on-ubuntu-22-04/  (for npm from nodejs)
* https://www.reddit.com/r/neovim/comments/1741i6m/treesitter_executable_not_found/



### Map Caps to CTRL

Use `gnome-tweaks` 
The command is `setxkbmap -option "ctrl:nocaps"` 


### Configure keyboard shortcuts

Go to `Keyboard` -> `Customize Shortcuts` 

To add a new launcher for kitty, etc., go to `Keyboard` -> `Customize Shortcuts` -> `Custom shortcuts` -> `+`

* bind `rofi -show drun` to `Alt d` in keyboard shortcuts
* bind `/usr/bin/kitty` to `Alt Enter` in keyboard shortcuts


### Navigation and file system

* search with `fd` --- see https://github.com/sharkdp/fd, brush up skills
* when searching, optionally pipe results to fzf
* use zoxide to navigate


### Tailscale 

Follow website instructions (curl)


### Zoom

Follow the instructions on zoom website


### Install and Set Fonts

Install Nerd Fonts according to [these instructions](https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0)

* Download a Nerd Font
* Unzip and copy to `~/.local/share/fonts`
* Run the command `fc-cache -fv` to manually rebuild the font cache

* To see the list of fonts visible to kitty use `kitty +list-fonts`


### SSH

To generate a key, use

* `ssh-keygen -t rsa` and then your ssh passphrase

Now `ssh-add` when you start your machine.  To copy it to the server, use

* `ssh-copy-id -i ~/.ssh/mykey user@host`

To start the server

* `sudo apt install openssh-server`
* `sudo systemctl start ssh`
* `sudo systemctl status ssh`

If `ssh-add` does not start, try 

```
eval `ssh-agent -s`  
ssh-add
```


### Versioned Tools

* `git clone https://github.com/jstac/versioned_tools`
* `ch ~` and `mkdir bin` and `cd bin`.
* `ln -s gh_synced/versioned_tools/*.py .`


### LaTeX

Install "vanilla" texlive for latest packages rather than Ubuntu package.

* sudo apt install perl wget fontconfig xzdec
* wget --no-check-certificate https://ctan.math.illinois.edu/systems/texlive/tlnet/install-tl-unx.tar.gz
* tar -xf install-tl-unx.tar.gz
* cd install-tl-*/
* sudo ./install-tl


Useful references for the install:

* https://linux.how2shout.com/installing-vanilla-tex-live-on-debian-12-or-11-linux/
* https://www.tug.org/texlive/quickinstall.html

TeXlive package manager:

* https://www.tug.org/texlive/doc/tlmgr.html#EXAMPLES

* `mkdir ~/texmf/bibtex/bst` and add ecta.bst, etc.
* do `texhash ~/texmf`, check with `kpsewhich ecta.bst`


### GH Credentials

https://docs.github.com/en/github/extending-github/git-automation-with-oauth-tokens


## Local External GPU + JAX

* Select the latest nvidia driver in "additional drivers" hardware setting
* follow latest instructions for installing JAX
* Build `nvtop` from source
* Disable Wayland -- see above 

Notes: 

* `inxi -Gxx` gives information on your graphics drivers

(Building nvtop from source required a recent version of cmake, which I
installed via one of the graphical software installers and I guess it installed
via snap (since the installed version is newer than what's in the Ubuntu apt
repo).)

See also https://manual.quantecon.org/tools/gpu.html#using-egpu-with-ubuntu


## Running Jupyter on a Remote Machine

1. On the local machine, set up reverse tunnel to remote via `ssh -L 8080:localhost:8080 john@remote`
1. `ssh remote` and 
    1. navigate to where md / ipynb files are
    1. run `jupyter notebook --no-browser --port=8080`
    1. cp `http://localhost:8080/?token=XXX` into local browser



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

