# Versioned Dotfiles

Configuration files for Ubuntu development environment with zsh, neovim, yazi, and modern CLI tools.

## Machines

Inventory of machines running this setup. Update as machines are added/retired.

### `xps` — laptop (primary)
- **OS:** Ubuntu 24.04 LTS
- **CPU:** Intel i7-1165G7 (8 logical cores)
- **RAM:** 16 GB
- **GPU:** Intel Iris Xe (integrated)
- **Storage:** 512 GB NVMe (KIOXIA)
- **Tailscale:** `ssh-xps` → `100.110.168.124`

### `grips-zilla` — workstation (set up 2026-04-27)
- **OS:** Ubuntu 26.04 LTS
- **Mobo:** MSI PRO Z790-P (MS-7E06), MSI Click BIOS 5
- **CPU:** Intel i7-13700KF (16c/24t)
- **RAM:** 64 GB
- **GPU:** NVIDIA RTX 4080 (16 GB) — install proprietary driver post-install (Software & Updates → Additional Drivers)
- **Storage:** 1 TB NVMe (WD_BLACK SN770) for system + 4 TB HDD (WDC WD40EZAZ) ext4 mounted at `/data` (UUID-based fstab entry)
- **Tailscale:** `ssh-grips` → `100.91.249.128`
- **BIOS quirk:** Secure Boot toggle not exposed in this firmware revision. Left enabled; Ubuntu signs its own kernel and NVIDIA driver install handles MOK enrollment.

### Other reachable hosts (via Tailscale, see `dot_config/zsh/zshrc` aliases)
- `ssh-gpu`, `ssh-nuc`, `ssh-precision` — additional remote machines

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
#    - gnome-tweaks: Caps Lock → Ctrl
#    - Settings → Keyboard: bind Alt+d (wofi/rofi launcher) and Alt+Enter (kitty)
#    - Software & Updates → Additional Drivers (NVIDIA, if applicable)
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

#### 2. Configure Caps Lock → Ctrl

In **gnome-tweaks → Keyboard → Additional Layout Options → Caps Lock behavior**, tick "Caps Lock is also a Ctrl". This is Wayland-safe and persists across logins.

(Older docs suggested `setxkbmap -option "ctrl:nocaps"` — that only works on X11 and is deprecated for this setup.)

#### 3. Configure Custom Shortcuts

**Settings → Keyboard → Keyboard Shortcuts → View and Customize Shortcuts → Custom Shortcuts**, add:

- **Launcher** → `Alt+d`
  - Wayland: `wofi --show drun`
  - X11: `rofi -show drun`
- **Terminal** → `Alt+Return` → `/usr/bin/kitty`

`rofi` doesn't run natively on Wayland (uses XWayland with degraded behavior); `wofi` is a Wayland-native equivalent that uses the same `--show drun` mode.

---

## Claude Code Installation

### Migrating from npm to Native Installation

**Problem:** If you installed Claude Code via npm (`npm install -g @anthropic-ai/claude-code`), you may experience auto-update failures due to npm permission issues. The native installation is recommended because it:
- Provides a single self-contained executable with no Node.js dependency
- Offers improved auto-updater stability
- Avoids npm permission problems

**Solution - Switch to Native Installation:**

1. **Uninstall the npm version:**
   ```bash
   sudo npm uninstall -g @anthropic-ai/claude-code
   ```

2. **Install the native version:**
   ```bash
   curl -fsSL https://claude.ai/install.sh | bash
   ```

**Note** You might also need to run `sudo rm /usr/local/bin/claude` to purge the global version.

3. **Restart your shell** (or run `source ~/.bashrc` or `source ~/.zshrc` depending on your shell)

4. **Verify the installation:**
   ```bash
   claude --version
   ```
5. Log in
   ```bash
    claude /login
   ```


The native installer will set up the PATH.

---

## Display Server (X11 vs Wayland)

**Ubuntu 26.04+: Wayland only.** Upstream GNOME removed the X11 session in GNOME 47, and Ubuntu 26.04 ships GNOME without it — `/usr/share/xsessions/` is empty and there's no `gnome-session-xsession` package. `WaylandEnable=false` in `/etc/gdm3/custom.conf` is a no-op there.

**Ubuntu 24.04 and earlier: both available.** Pick at the GDM login screen via the gear icon: "Ubuntu" (Wayland) or "Ubuntu on Xorg" (X11). To force X11 for all logins on these versions, uncomment `WaylandEnable=false` in `/etc/gdm3/custom.conf`.

If you actually need an X11 desktop on 26.04+ (e.g., for a tool with no Wayland equivalent), switch desktop environments rather than fighting GNOME: XFCE (`xubuntu-desktop`), MATE (`ubuntu-mate-desktop`), Cinnamon, or KDE Plasma all retain X11 sessions.

Verify session: `echo $XDG_SESSION_TYPE` (`wayland` or `x11`).

### Wayland-related package swaps
- `rofi` → `wofi` (rofi can't init under Wayland; install.sh installs both — pick at the shortcut binding)
- `xdotool` → `wtype` or `ydotool`
- `xclip` → `wl-clipboard` (`wl-copy` / `wl-paste`)

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

### GH CLI

Follow instructions at https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian

### Zoom

Download and install from https://zoom.us/download

---

## Machine-Specific Configuration

### NVIDIA GPU + JAX

1. Install the recommended driver:
   ```bash
   ubuntu-drivers devices              # confirm what's recommended
   sudo ubuntu-drivers install         # auto-installs the recommended one
   ```
   For RTX 20-series and newer, prefer the `-open` variant (NVIDIA Open GPU Kernel Modules) — recommended by NVIDIA, signed by Canonical so no MOK enrollment needed under Secure Boot.
2. Reboot, then verify with `nvidia-smi` (driver + GPU listed).
3. Install JAX: https://jax.readthedocs.io/en/latest/installation.html
   ```bash
   pip install -U "jax[cuda12]"
   ```
4. Build `nvtop` from source for GPU monitoring (or `sudo apt install nvtop`).

**Check GPU status:**
```bash
inxi -Gxx
```

See also: https://manual.quantecon.org/tools/gpu.html#using-egpu-with-ubuntu

### Birthday reminder (grips-zilla)

A small Python script wired up as a daily systemd user timer. It emails birthday reminders to `john.stachurski@gmail.com` and `emailcleo@gmail.com`. Replaces the original Python 2 script in `older_scripts/bdaychecker.py`. Source lives at `~/gh_synced/versioned_tools/bdaychecker/`, version-controlled and synced via git so edits made on the laptop reach the workstation through `git pull`.

#### When it fires

The timer triggers `bdaychecker.service` once a day at **07:00 JST** on grips-zilla. The unit declares `Persistent=true`, so a run that gets missed because the machine was off or asleep is rescheduled for the next boot — at worst, a reminder lands about a day late instead of being lost. User lingering is on (`loginctl enable-linger john`), so the timer runs whether or not anyone is logged in.

#### Reminder cadence

For each entry in `birthdays.yaml` the script considers two trigger dates:

- **10 days before the birthday** — a planning reminder.
- **The birthday itself** — the day-of nudge.

So each birthday produces two emails per year. The 10-day lead is the constant `LEAD_DAYS` at the top of `bdaychecker.py` — change it there and re-pull on grips-zilla if you want a different lead time.

#### Dependencies

Python 3 (any modern version) plus PyYAML. On Debian/Ubuntu, PyYAML ships as the apt package `python3-yaml` and is preinstalled on Ubuntu 24.04+. If a fresh install ever errors with `ModuleNotFoundError: No module named 'yaml'`, run `sudo apt install -y python3-yaml`.

Everything else (`smtplib`, `ssl`, `email.message`, `pathlib`, `datetime`) is in the standard library.

#### Components

| Path | Role |
|---|---|
| `bdaychecker.py` | The script. Sends via Gmail SMTP on port 465 (implicit TLS). |
| `birthdays.yaml` | Hand-editable list of `name` + `date` (DD-MM). |
| `systemd/bdaychecker.service` | Runs the script. Symlinked into `~/.config/systemd/user/`. |
| `systemd/bdaychecker.timer` | Fires the service daily at 07:00. |
| `systemd/bdaychecker-failure.service` | `OnFailure=` hook; records a flag file on failure. |
| `~/.config/bdaychecker/smtp_password` | Gmail app password, mode `600`. **Not in git.** |
| `~/.local/state/bdaychecker/last_failure` | Created automatically when a run fails. Absence = no recent failure. |

#### Fresh install on a new machine

```bash
# 0. (If PyYAML is missing — preinstalled on Ubuntu 24.04+):
sudo apt install -y python3-yaml

# 1. Create a Gmail app password at https://myaccount.google.com/apppasswords
#    Requires 2FA on the Google account. Label it "bdaychecker".

# 2. Save the password (16 chars; spaces are OK — script strips them):
mkdir -p ~/.config/bdaychecker && chmod 700 ~/.config/bdaychecker
nano ~/.config/bdaychecker/smtp_password
chmod 600 ~/.config/bdaychecker/smtp_password

# 3. Smoke-test (sends one real email to both recipients):
python3 ~/gh_synced/versioned_tools/bdaychecker/bdaychecker.py --test-email

# 4. Install systemd units (symlinks, so future git pulls update them):
mkdir -p ~/.config/systemd/user
ln -sf ~/gh_synced/versioned_tools/bdaychecker/systemd/bdaychecker.service         ~/.config/systemd/user/
ln -sf ~/gh_synced/versioned_tools/bdaychecker/systemd/bdaychecker.timer           ~/.config/systemd/user/
ln -sf ~/gh_synced/versioned_tools/bdaychecker/systemd/bdaychecker-failure.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now bdaychecker.timer

# 5. Enable lingering so the timer fires when no one is logged in:
loginctl enable-linger $USER
```

#### Editing the birthday list

Open `bdaychecker/birthdays.yaml` in any editor. Each entry is a single-line YAML mapping with two keys:

```yaml
- {name: Jane Doe,    date: 25-12}
- {name: Robert Roe,  date: 03-07}
```

`date` is `DD-MM`, no year. The script reads the file fresh on every run, so commit, push, and `git pull` on grips-zilla is enough — no service restart needed. The next 07:00 run picks up the change.

*Caveat: Feb 29 birthdays are silently skipped in non-leap years.* The match is exact `(day, month)` against today's date, and Feb 29 doesn't exist 3 years out of 4. None of the current entries are affected; if you ever add a Feb 29 person, treat them as 28-Feb to get yearly coverage.

#### Day-to-day operations

| Task | Command |
|---|---|
| When does the timer next fire? | `systemctl --user list-timers bdaychecker.timer` |
| What happened in past runs? | `journalctl --user -u bdaychecker.service` |
| Force a run right now | `systemctl --user start bdaychecker.service` |
| Dry-run against a specific date | `python3 ~/gh_synced/versioned_tools/bdaychecker/bdaychecker.py --dry-run --date 2026-04-29` |
| Send a one-off test email | `python3 ~/gh_synced/versioned_tools/bdaychecker/bdaychecker.py --test-email` |

#### Failure handling

If `bdaychecker.service` exits non-zero — bad YAML, SMTP auth failure, network down at run time, etc. — systemd's `OnFailure=` triggers `bdaychecker-failure.service`. That sibling unit writes a timestamp plus the last 30 lines of the bdaychecker journal to `~/.local/state/bdaychecker/last_failure`. The file is overwritten (not appended) on each failure, so its contents always reflect the most recent one. Full failure history lives in the journal.

The shared `dot_config/zsh/zshrc` checks for that file on every interactive shell start and prints a red `bdaychecker failed:` warning if it exists. So the next time you `ssh-grips` (or open any local terminal), the failure will be in your face without you having to remember to look. The check is gated on file existence, so it's a no-op on machines where bdaychecker doesn't run — safe to keep in the shared zshrc.

To resolve: read the file, fix the underlying cause (often a bad YAML edit or a revoked app password), then `rm ~/.local/state/bdaychecker/last_failure` to acknowledge.

We deliberately don't email about failures because email is the failing channel.

#### Rotating the Gmail app password

1. Delete the current entry at https://myaccount.google.com/apppasswords.
2. Create a new one labelled `bdaychecker`.
3. On grips-zilla: `nano ~/.config/bdaychecker/smtp_password`, paste the new password, save. Then `chmod 600 ~/.config/bdaychecker/smtp_password` to be safe.
4. Verify: `python3 ~/gh_synced/versioned_tools/bdaychecker/bdaychecker.py --test-email`.

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
- `photoresize` - Resize images

(Earlier versions also installed `check_sync`/`pull_sync`/`push_sync` symlinks. These were retired once `~/rsync_dir` moved to a git repo at `github.com/jstac/rsync_dir`.)

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

### `cargo install tree-sitter-cli` fails with `'stdbool.h' file not found`

The `rquickjs-sys` build (a transitive dep of recent tree-sitter-cli) uses bindgen, which needs a full clang toolchain to find C standard headers. The apt list in `install.sh` now installs `clang` and `libclang-dev` to prevent this. If you hit it on an existing system:

```bash
sudo apt install -y clang libclang-dev
cargo install tree-sitter-cli
```

### Large 4 TB HDD partitioning (workstation pattern)

For an additional secondary HDD (mounted at `/data`):

```bash
sudo wipefs -a /dev/sdX
sudo sgdisk --zap-all /dev/sdX
sudo parted -a optimal /dev/sdX mklabel gpt
sudo parted -a optimal /dev/sdX mkpart data ext4 0% 100%
sudo mkfs.ext4 -L data /dev/sdX1
sudo mkdir /data
echo "UUID=$(sudo blkid -s UUID -o value /dev/sdX1)  /data  ext4  defaults,noatime  0  2" | sudo tee -a /etc/fstab
sudo mount -a
sudo chown $USER:$USER /data
```

**Always verify `findmnt /` shows the OS disk (`nvme...`) before running `wipefs` or `sgdisk` on a different device.**

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
