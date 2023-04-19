# This file needs to live in $HOME.  It's main job is to 
# point zsh to $HOME/.config/zsh as a source of config files.

# Set XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# Zsh home
export ZSH=$HOME/.config/zsh
ZDOTDIR=$HOME/.config/zsh

# Editor
export EDITOR="nvim"
export VISUAL="nvim"


# Codon compiler path (added by install script)
export PATH=/home/john/.codon/bin:$PATH
