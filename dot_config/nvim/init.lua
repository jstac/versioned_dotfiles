
-- Current hack: just run old vimrc

vim.cmd([[runtime vimrc]])


-- Move to here over time:

-- require('options')
-- require('keymaps')
-- require('commands')
-- require('plugins')
-- require('themes')  -- Theme at end to prevent overwrite by other plugins
--
--
-- Useful references:
--  - https://github.com/nanotee/dotfiles/tree/master/.config/nvim
--  - https://github.com/glepnir/nvim
--  - https://github.com/guxuerui/nvim-0.8
--  - https://github.com/daalfox/nvim/tree/main/lua
--  - https://github.com/evantravers/dotfiles/tree/master/nvim
--  - https://github.com/GideonWolfe/nvim-lua/tree/main/lua
--  - https://www.reddit.com/r/neovim/comments/qnjlvu/lists_of_luabased_nvim_config_files/
--  - https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
