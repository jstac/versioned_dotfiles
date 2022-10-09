# =========== paths =========== #

# General path additions
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

# Anaconda3 
export PATH="/home/john/anaconda3/bin:$PATH"  # commented out by conda initialize

# This one is fiddly.  Added /home/john/anaconda3/lib to make numba 
# cuda happy
# and then /usr/lib/x86_64-linux-gnu because tmux was failing.  Haven't
# retested cuda since last change.
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:/home/john/anaconda3/lib"

# For Nvidia cuda toolkit --- can run binaries in /usr/local/cuda
export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} 
export PATH=/usr/local/cuda-11.8/bin${PATH:+:${PATH}}

# =========== themes and plugins =========== #

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for more options
ZSH_THEME="cdimascio-lambda"

plugins=(git 
         vi-mode)

# =========== bindings =========== #

# Tells vi-mode to map jj to escape
bindkey "jj" vi-cmd-mode

# =========== zoxide ============= #

eval "$(zoxide init zsh)"
# You may have to rebuild your cache by running rm ~/.zcompdump*; compinit

# =========== exports =========== #

export EDITOR='vi'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export BAT_THEME="TwoDark"

# Control fzf (what a direct call to fzf triggers)
export FZF_DEFAULT_COMMAND="fdfind --exclude={.git,_minted} --type f"

# =========== aliases =========== #

alias fd="fdfind"
alias jp="jupyter notebook"
alias xo="xdg-open"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias mu="zathura"
alias bat="batcat"
alias cat="batcat"     # map cat to bat
alias pip='noglob pip' # stop zsh from screwing up pip extras


# ======== oh-my-zsh stuff ====== #

export ZSH="$HOME/.oh-my-zsh"   # Path to oh-my-zsh installation
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode reminder  # remind me to update 
zstyle ':omz:update' frequency 20

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Set the command execution time stamp shown in the history command output.
# HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

