-- Install package manager
--
--
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- plugins handled by Lazy are listed in plugins/init.lua

require('options')
require('keymaps')
require('colorscheme')
require('plugins')

-- the following helps reload nvim configs as discussed in
-- https://stackoverflow.com/questions/72412720/how-to-source-init-lua-without-restarting-neovim
-- It is paired with
-- vim.api.nvim_set_keymap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", opts)

-- Add modules here
local modules = {
  "options",
  "keymaps",
  "colorscheme",
}

-- Refresh module cache
for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end

