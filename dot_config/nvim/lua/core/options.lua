local options = {
    showmode = false,               -- show da mode (not necessary when using status line)
    bs = [[indent,eol,start]],      -- backspace over everything
    incsearch = false,              -- incremental search (sucks)
    syntax = "on",                  -- syntax highlighting
    hlsearch = true,                -- highlight search matches
    textwidth = 80,
    autoread = true,                -- refresh buffers that changed on disk
    splitbelow = true,              -- more natural splits
    splitright = true,              -- more natural splits
    vb = false,                     -- no bell
    cursorline = false,              -- highlight cursor line
    showmatch = true,               -- shows matching parenthesis
    tabstop = 4,                    -- no. of spaces when press tab
    expandtab = true,               -- tabs expanded into spaces
    timeoutlen = 500,
    shiftwidth = 4,
    smarttab = true,
    autoindent = true ,             -- use current level of indent in next line
    wildmode = {"longest", "list"}, -- bash-like tab completion when opening files
    hidden = true,                  -- can open new files w/o saving existing
    foldmethod = "indent",
    foldlevel = 99,                 -- tell nvim not to initial folds
    formatoptions = "tqn"
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
