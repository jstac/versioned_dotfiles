set fish_key_bindings fish_user_key_bindings

# Define alias in config file
alias vi="nvim"
alias jp="jupyter notebook"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/john/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

