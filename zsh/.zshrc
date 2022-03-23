# =========== paths =========== #

# General path additions
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

# Anaconda3 and Julia
export PATH="/home/john/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="$PATH:/home/john/julia-1.7.0/bin"

# This one is fiddly.  Added /home/john/anaconda3/lib to make numba cuda happy
# and then /usr/lib/x86_64-linux-gnu because tmux was failing.  Haven't
# retested cuda since last change.
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:/home/john/anaconda3/lib"

# =========== themes and plugins =========== #

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for more options
ZSH_THEME="frisk"

plugins=(git 
         vi-mode)

# =========== bindings =========== #

# Tells vi-mode to map jj to escape
bindkey "jj" vi-cmd-mode

# =========== exports =========== #

export EDITOR='vi'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export BAT_THEME="TwoDark"

# =========== aliases =========== #

alias jp="jupyter notebook"
alias xo="xdg-open"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias mu="zathura"
alias bat="batcat"
alias cat="batcat"
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

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Set the command execution time stamp shown in the history command output.
# HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

