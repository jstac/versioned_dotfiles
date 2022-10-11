# =========== history ====================== #

export HISTFILE=$ZSH/.zsh_history
# How many commands zsh will load to memory.
export HISTSIZE=10000
# How maney commands history will save on file.
export SAVEHIST=10000
# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS
# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

# =========== themes and plugins =========== #

# Themes
source "$HOME/.config/zsh/themes/spaceship-prompt/spaceship.zsh"

# Plugins
source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
#

# zsh-vi-mode config
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj  # for insert mode, keep default `^[` in other modes

# spaceship config 

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# =========== bindings =========== #

# Tells vi-mode to map jj to escape
bindkey "jj" vi-cmd-mode

# =========== zoxide ============= #

eval "$(zoxide init zsh)"
# You may have to rebuild your cache by running rm ~/.zcompdump*; compinit

# =========== exports =========== #

# General path additions
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
# Anaconda3 
export PATH="/home/john/anaconda3/bin:$PATH"  # commented out by conda initialize
# This one is fiddly.  Added /home/john/anaconda3/lib to make numba 
# cuda happy
# and then /usr/lib/x86_64-linux-gnu because tmux was failing.  Haven't
# retested cuda since last change.
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:/home/john/anaconda3/lib"

export EDITOR='vi'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export BAT_THEME="TwoDark"

# Control fzf (what a direct call to fzf triggers)
export FZF_DEFAULT_COMMAND="fdfind --exclude={.git,_minted} --type f"

# =========== aliases =========== #

alias ls='ls --color'
alias ll='ls -la --color'
alias fd="fdfind"
alias jp="jupyter notebook"
alias xo="xdg-open"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias n="nnn"
alias mu="zathura"
alias bat="batcat"
alias cat="batcat"     # map cat to bat
alias pip='noglob pip' # stop zsh from screwing up pip extras

alias gs='git status'
alias ga='git add -A'
alias gp='git push'
alias gcm='git commit -am misc'
alias grs='git remote show'

