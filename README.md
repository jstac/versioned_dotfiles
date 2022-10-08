# Versioned Dotfiles


## Computer Set Up

Install latest Ubuntu and then the budgie desktop via apt

### Install Basic Software

* install chromium, rofi, latex, git, kitty, suckless-tools, bat, neovim, tmux, fd-find, fzf

## Examine your set up

* `inxi -Gxx` gives information on your graphics drivers

### Anaconda

Install as usual.  Create configs with 

* `jupyter notebook --generate-config`  (set browser to `chomium`)
* `ipython profile create`

### Install zsh 

First change root user:

* `sudo -s` followed by `chsh -s /bin/zsh root`

Now the user:

* `chsh -s /bin/zsh` 
* install oh-my-zsh 
* lambda theme is at https://github.com/cdimascio/lambda-zsh-theme


### Set Up Dotfiles

Do the obvious, `source ~/.zshrc`, `source ~/.tmux.conf`

### Map Caps to CTRL

The remap is in `.profile` and consider `ln -s .profile .xprofile`

The command is `setxkbmap -option "ctrl:nocaps"` 

(In Windows, use `powertoys` from MS store)

### Configure keyboard shortcuts

Go to `Keyboard` -> `Customize Shortcuts` 

To add a new launcher for kitty, etc., go to `Keyboard` -> `Customize Shortcuts` -> `Custom shortcuts` -> `+`

Rofi: bind `rofi -show drun` to `Alt d` in keyboard shortcuts

### Set up neovim 

* `pip install -U pip`
* `pip install neovim`
* follow instructions to install and set up `vim-plug` from junegunn
* Run `:PlugInstall` 

### Navigation and file system

* search with `fd` --- see https://github.com/sharkdp/fd, brush up skills
* when searching, optionally pip results to fzf
* use zoxide to navigate

### Tailscale 

Follow website instructions and install deb package.

On Windows may need `start tailscaled` to start the daemon.

### Zoom

Follow the instructions on zoom website


### Install and Set Fonts

Install Nerd Fonts according to [these instructions](https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0)

* Download a Nerd Font
* Unzip and copy to `~/.local/share/fonts`
* Run the command `fc-cache -fv` to manually rebuild the font cache


### SSH

To generate a key, use

* `ssh-keygen -t rsa` and then your ssh passphrase

Now `ssh-add` when you start your machine.  To copy it to the server, use

* `ssh-copy-id -i ~/.ssh/mykey user@host`

To start the server

* `sudo apt install openssh-server`
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
* `mkdir ~/texmf/bibtex/bst` and add ecta.bst, etc.
* do `texhash ~/texmf`, check with `kpsewhich ecta.bst`


### GH Credentials

https://docs.github.com/en/github/extending-github/git-automation-with-oauth-tokens

git config --global user.email "john.stachurski@gmail.com"
git config --global user.name "John Stachurski"
git config --global credential.helper "cache --timeout=8640000"


## Notes on the GPU

* If necessary, `sudo apt install nvidia-driver-xxx` (not needed on Ubuntu 22.x LTS)
* install CUDA toolkit from nvidia website (currently https://developer.nvidia.com/cuda-downloads, follow Ubuntu instructions)
* build `nvtop` from source

Install JAX via pip -- current install on XPS used

`pip install --upgrade "jax[cuda]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html`


## For Japanese

Just use Google Japanese input

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

