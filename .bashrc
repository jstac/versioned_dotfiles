
alias padon="synclient TouchpadOff=0"
alias padoff="synclient TouchpadOff=1"
alias tmux="tmux -2"

# added by Anaconda 2.2.0 installer
export PATH="/home/john/anaconda3/bin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# helpful to get the right colors in the terminal
export TERM="screen-256color"
alias ls='ls --color=auto'

. /home/john/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

