# Versioned Dotfiles

Configuration files for Ubuntu development environment with zsh, neovim, yazi, and modern CLI tools.

## TL;DR - Fresh Install

```bash
# 1. Install Node.js/npm (prerequisite - see below for details)

# 2. Download Nerd Fonts to ~/Downloads
# Visit https://www.nerdfonts.com/font-downloads
# Recommended: FiraCode, FiraMono, Hack, CascadiaCode

# 3. Clone this repo
mkdir -p ~/gh_synced && cd ~/gh_synced
git clone <your-repo-url> versioned_dotfiles

# 4. Run the install script
cd versioned_dotfiles
./install.sh

# 5. Complete post-install steps (shown by script):
#    - chsh -s /bin/zsh (then logout/login)
#    - Configure keyboard shortcuts in gnome-tweaks
#    - setxkbmap -option "ctrl:nocaps"
```

---

## Quick Start

### Prerequisites

1. **Fresh Ubuntu installation** with apt working
2. **Node.js and npm** installed
   - Verify: `node --version` and `npm --version`
   - Install from: https://nodejs.org/ or via package manager

3. **Clone this repository:**
   ```bash
   mkdir -p ~/gh_synced
   cd ~/gh_synced
   git clone <this-repo> versioned_dotfiles
   ```

4. **Download Nerd Fonts** (before running install script):
   - Visit https://www.nerdfonts.com/font-downloads
   - Download to `~/Downloads/`: FiraCode, FiraMono, Hack, CascadiaCode (recommended)

### Automated Installation

```bash
cd ~/gh_synced/versioned_dotfiles
./install.sh
```

**Options:**
- `--skip-sudo` - Skip steps requiring sudo (if already done)
- `--skip-builds` - Skip building from source (Yazi)

The script will:
- Install system packages via apt
- Install Rust and cargo tools (eza, git-delta, vivid, tree-sitter-cli)
- Build and install Yazi file manager
- Install Starship prompt and Bitwarden CLI
- Install Nerd Fonts from ~/Downloads
- Configure git
- Create all dotfile symlinks
- Set up zsh with plugins
- Clone and link versioned_tools
- Clean up default directories (with prompt)
- Generate SSH keys (with prompt)

### Post-Install Manual Steps

After running `install.sh`, complete these steps:

#### 1. Change Default Shell to Zsh

```bash
chsh -s /bin/zsh
```

Then **log out and log back in**.

#### 2. Configure Keyboard Shortcuts (gnome-tweaks)

Open gnome-tweaks and configure:

**Keyboard → Additional Layout Options:**
- Caps Lock behavior → "Caps Lock is also a Ctrl"

**Keyboard → Customize Shortcuts → Custom shortcuts:**
- Add: `rofi -show drun` → `Alt+d`
- Add: `/usr/bin/kitty` → `Alt+Enter`

**Or run this after each login:**
```bash
setxkbmap -option "ctrl:nocaps"
```

---

## Optional Components

### Neovim (Install from Source)

For latest features, build from source:

```bash
# See: https://github.com/neovim/neovim/blob/master/BUILD.md
```

**After install, configure Treesitter:**
```vim
:TSUpdate
:TSInstall vim
:TSInstall latex
:TSInstall julia
```

If treesitter CLI issues occur:
- Already installed by install.sh: `tree-sitter-cli` via cargo
- See: https://www.reddit.com/r/neovim/comments/1741i6m/treesitter_executable_not_found/

### Python/Anaconda

For Python development:

```bash
# Download Anaconda installer
wget https://repo.anaconda.com/archive/Anaconda3-<VERSION>.sh

# Install
cd ~/Downloads
bash ./Anaconda3-<VERSION>.sh

# Configure Jupyter
jupyter notebook --generate-config  # set browser to chromium
ipython profile create

# Update pip and install neovim support
pip install -U pip
pip install neovim
```

### LaTeX (Vanilla TeXlive)

Install latest TeXlive (not Ubuntu's older package):

```bash
sudo apt install perl wget fontconfig xzdec
wget --no-check-certificate https://ctan.math.illinois.edu/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xf install-tl-unx.tar.gz
cd install-tl-*/
sudo ./install-tl
```

**References:**
- https://linux.how2shout.com/installing-vanilla-tex-live-on-debian-12-or-11-linux/
- https://www.tug.org/texlive/quickinstall.html
- TeXlive package manager: https://www.tug.org/texlive/doc/tlmgr.html#EXAMPLES

**Custom bibliography styles:**
```bash
mkdir -p ~/texmf/bibtex/bst
# Add custom .bst files (e.g., ecta.bst)
texhash ~/texmf
kpsewhich ecta.bst  # verify
```



### Firefox (Non-Snap Version)

Ubuntu's snap version can be problematic. Install .deb version:

See: https://askubuntu.com/questions/1502031/how-to-install-firefox-directly-from-mozilla-with-apt

Note: Manual .deb installations don't auto-update.

Install bitwarden Firefox extension if necessary


### Tailscale

```bash
# Follow instructions at https://tailscale.com/download/linux
```

### Zoom

Download and install from https://zoom.us/download

---

## Machine-Specific Configuration

### Disable Wayland (for Rofi and GPU)

Edit `/etc/gdm3/custom.conf` and uncomment:
```
WaylandEnable=false
```

Restart display manager or reboot.

### External GPU + JAX

1. Select latest nvidia driver in "Additional Drivers" settings
2. Install JAX: https://jax.readthedocs.io/en/latest/installation.html
3. Build `nvtop` from source for GPU monitoring
4. Disable Wayland (see above)

**Check GPU status:**
```bash
inxi -Gxx
```

See also: https://manual.quantecon.org/tools/gpu.html#using-egpu-with-ubuntu

---

## Remote Development

### SSH Key Setup

**Note:** Basic SSH key generation is automated by `install.sh` (with prompt).

**To copy key to remote server:**
```bash
ssh-copy-id -i ~/.ssh/id_rsa user@host
```

**If ssh-agent doesn't start automatically:**
```bash
eval `ssh-agent -s`
ssh-add
```

**Optional: Start SSH server**
```bash
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl status ssh
```

### Remote Jupyter Notebook

**On local machine:**
```bash
ssh -L 8080:localhost:8080 user@remote
```

**On remote machine:**
```bash
cd /path/to/notebooks
jupyter notebook --no-browser --port=8080
# Copy the http://localhost:8080/?token=XXX URL to local browser
```

---

## AWS EC2 Setup

### Launch Instance

1. Login to AWS Console → EC2
2. Choose region
3. Create/select security key-pair
4. Launch Ubuntu 64-bit instance
5. Enable ports: 22 (SSH), 8000 (Jupyter)

### Connect and Configure

```bash
ssh -i /path/to/pem-key ubuntu@<PUBLIC-DNS>
sudo apt-get update
```

### Jupyter on EC2

```bash
# Install Anaconda (see Python section above)

# Generate config
jupyter notebook --generate-config
jupyter notebook password

# Edit ~/.jupyter/jupyter_notebook_config.py
```

Add:
```python
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8000
```

Start: `jupyter notebook`

Access: `http://<PUBLIC-IP>:8000`

---

## CLI Tools Reference

**Navigation:**
- `fd` - Modern find (installed as `fdfind`)
- `fzf` - Fuzzy finder
- `z` - Smart directory jumper (zoxide)
- `yazi` - Terminal file manager

**Development:**
- `bat` - Better cat (installed as `batcat`)
- `rg` - Ripgrep (fast search)
- `eza` - Better ls
- `delta` - Better git diff

**Custom Tools** (in ~/bin after install):
- `check_sync` - Check rsync directory status
- `pull_sync` - Pull from rsync directory
- `push_sync` - Push to rsync directory
- `photoresize` - Resize images

---

## Troubleshooting

### Fonts not showing in Kitty

```bash
# List available fonts
kitty +list-fonts

# Rebuild cache
fc-cache -fv
```

### Zsh plugins not loading

```bash
# Ensure directories exist
ls ~/.config/zsh/plugins/

# Re-source
source ~/.config/zsh/.zshrc
```

### Git credentials not caching

```bash
git config --global credential.helper "cache --timeout=8640000"
```

---

## Repository Structure

```
versioned_dotfiles/
├── install.sh              # Automated installation script
├── README.md               # This file
├── install_log.txt         # Legacy install notes (deprecated)
├── top_level/              # Dotfiles for ~/
│   ├── zshenv
│   └── latexmkrc
└── dot_config/             # Dotfiles for ~/.config/
    ├── starship.toml
    ├── kitty/
    ├── nvim/
    ├── yazi/
    ├── zathura/
    ├── zsh/
    └── tmux/
```

---

## GitHub Credentials

For pushing to private repos, set up a personal access token:

https://docs.github.com/en/github/extending-github/git-automation-with-oauth-tokens
