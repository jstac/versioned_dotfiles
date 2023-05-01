
require('core.options')
require('core.keymaps')
require('core.plugins')
require('core.plugin_config')
require('core.colorscheme')


-- the following helps reload nvim configs as discussed in
-- https://stackoverflow.com/questions/72412720/how-to-source-init-lua-without-restarting-neovim
-- It is paired with
-- vim.api.nvim_set_keymap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", opts)

-- Add modules here
local modules = {
  "core.options",
  "core.keymaps",
  "core.colorscheme",
}

-- Refresh module cache
for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end

