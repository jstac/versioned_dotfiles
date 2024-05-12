
# =========== history ====================== #

export HISTFILE=$ZCACHEDIR/.zsh_history
# How many commands zsh will load to memory.
export HISTSIZE=100000
# How maney commands history will save on file.
export SAVEHIST=100000
# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS
# History won't show duplicates.
setopt HIST_FIND_NO_DUPS


# =========== plugins =========== #

# zsh-vi-mode
source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj  

# fast-syntax-highlighting
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh



#========== completion ========= #

zstyle ':completion:*' matcher-list \
    'm:{[:lower:]}={[:upper:]}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'


# ========= zoxide ============= #

eval "$(zoxide init zsh)"


# =========== paths =========== #

export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export PATH="/home/john/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"  

#export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:/home/john/anaconda3/lib"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# =========== editor ==========  # 

export EDITOR="nvim"
export VISUAL="nvim"


# ========== bat =============== #

export BAT_THEME="TwoDark"


# ========== fzf ================ #


# Control what a direct call to fzf triggers
export FZF_DEFAULT_COMMAND="fdfind --exclude={.git,_minted} --type f"


# =========== aliases =========== #

alias l='ls --color'
alias ls='ls --color'
alias ll='ls -la --color'
alias fd="fdfind"
alias jp="jupyter notebook"
alias jl="jupyter lab"
alias xo="xdg-open"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias c="clear"
alias mu="zathura"
alias tm="tmux"
alias bat="batcat"
alias cat="batcat"     # map cat to bat
alias pip='noglob pip' # stop zsh from screwing up pip extras
alias gls='git log --stat'
alias gs='git status'
alias ga='git add -A'
alias gc='git commit -am misc'
alias gp='git push'
alias gr='git remote show origin'
alias gr='git remote show origin'
alias ssh-gpu='ssh 100.90.220.42'


# == conda initialize (for setting up environments) == # 

__conda_setup="$('/home/john/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/john/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/john/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/john/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup


# =========== starship prompt ======= #

# first install the starship binary at https://starship.rs/

# This must be added to the end of .zshrc

eval "$(starship init zsh)"

# Config file is ~/.config/starship.toml

