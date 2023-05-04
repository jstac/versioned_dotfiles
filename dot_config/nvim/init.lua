
-- My init, largely based on https://github.com/cpow/cpow-dotfiles

require('core.options')
require('core.keymaps')
require('core.plugins')
require('core.plugin_config')
require('core.colorscheme')


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

