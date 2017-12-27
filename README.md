# versioned_dotfiles


## Install steps

* install rofi, latex, anaconda, julia

* add the following to `.profile`

```

# Permanently map CAPS to CTRL
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Start rofi
rofi -key-run F12 &

```

* map `synclient TouchpadOff=0` to `Ctrl-Super-Right` and `=1` to `Left`



## Other tips

* for vim, with system paste support: http://vim.wikia.com/wiki/Accessing_the_system_clipboard



