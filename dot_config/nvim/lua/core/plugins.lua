-- Load (or install and load) lazy.nvim 
--
-- (https://github.com/folke/lazy.nvim)
-- `:help lazy.nvim.txt` for more info
--

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

-- package list

local plugins = {

  -- Maps <Tab> to <C-p> 
  'ervandew/supertab',

  'akinsho/toggleterm.nvim', 

  'nvim-tree/nvim-tree.lua',

  'nvim-treesitter/nvim-treesitter',  -- syntax highlighting

  'lervag/vimtex',

  -- Unify tmux and vim split motion.  The set of mappings is visible
  -- in the relevant section of the tmux config file.
  'christoomey/vim-tmux-navigator',  


  -- fzf!
  { 'junegunn/fzf', run = './install --bin', },
  { 'ibhagwan/fzf-lua',
  -- optional for icon support
      requires = { 'nvim-tree/nvim-web-devicons' }
  },

  -- colors
  'ellisonleao/gruvbox.nvim',
  'folke/tokyonight.nvim',
  { 
    'michalbachowski/vim-wombat256mod', 
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
    
  { 
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- LSP config (also consider lspsaga for better UI)
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",


}

local opts = {}

require('lazy').setup(plugins, opts)
