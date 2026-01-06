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

  'tpope/vim-fugitive',

  'nvim-tree/nvim-web-devicons',

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  'akinsho/toggleterm.nvim',

  'nvim-treesitter/nvim-treesitter',  -- syntax highlighting

  'QuantEcon/myst-markdown-tree-sitter.nvim',

  'lervag/vimtex',

  -- Unify tmux and vim split motion.  The set of mappings is visible
  -- in the relevant section of the tmux config file.
  'christoomey/vim-tmux-navigator',

  -- Fast motion plugin - jump to any visible location with minimal keystrokes
  'folke/flash.nvim',

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',  -- Updated to fix vim.tbl_islist deprecation warning
      dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- LSP config
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",

  -- Completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',


  -- colorscheme
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
  },

}

local opts = {}

require('lazy').setup(plugins, opts)
