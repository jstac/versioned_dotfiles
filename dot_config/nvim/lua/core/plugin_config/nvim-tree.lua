
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    adaptive_size = true
  }
})

local M = {}

local bindings = {
  a = 'create',
  d = 'remove',
  l = 'parent_node',
  L = 'dir_up',
  K = 'last_sibling',
  J = 'first_sibling',
  o = 'system_open',
  p = 'paste',
  r = 'rename',
  R = 'refresh',
  x = 'cut',
  yl = 'copy_name',
  yp = 'copy_path',
  ya = 'copy_absolute_path',
  yy = 'copy',
  ['.'] = 'toggle_ignored',
  ['h'] = 'toggle_help',
  ['<bs>'] = 'close_node',
}

local function setup_bindings(buf_id)
  local cb = require('nvim-tree.config').nvim_tree_callback
  for key, value in pairs(bindings) do
    vim.api.nvim_buf_set_keymap(
      buf_id,
      'n',
      key,
      cb(value),
      { noremap = true, silent = true, nowait = true }
    )
  end
end

