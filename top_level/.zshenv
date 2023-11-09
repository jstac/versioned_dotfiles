# This file needs to live in $HOME.  It's only job is to 
# point zsh to the location of config and other files (history, 
# plugins, etc.)
#
# IMPORTANT: run mkdir ~/.local/share/zsh and mkdir ~/.cache/zsh
# 

# Set XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Zsh home
export ZDOTDIR=$HOME/.config/zsh
export ZHOMEDIR=$HOME/.config/zsh
export ZDATADIR=$XDG_DATA_HOME/zsh
export ZCACHEDIR=$XDG_CACHE_HOME/zsh


. "$HOME/.cargo/env"
