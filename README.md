# versioned_dotfiles


## Install steps

* install rofi, latex, anaconda, julia, zsh, git

* add the following to `.profile`

```

# Permanently map CAPS to CTRL
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Start rofi
rofi -key-run F12 &

```

* add `pullsync.py` etc to `bin` and then add dir `home/john/backups/sync_dir_backup`

* map `synclient TouchpadOff=0` to `Ctrl-Super-Right` and `=1` to `Left`



## Other tips

* for vim, with system paste support: http://vim.wikia.com/wiki/Accessing_the_system_clipboard



