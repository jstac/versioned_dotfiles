-- Load (or install and load) lazy.nvim 
--
-- (https://github.com/folke/lazy.nvim)
-- `:help lazy.nvim.txt` for more info
--

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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

  -- Migrated to nvim-treesitter main branch. Requires Neovim 0.12+ and
  -- tree-sitter-cli 0.26.1+ (installed via package manager, not npm).
  -- main is a "full incompatible rewrite" — see treesitter.lua for setup.
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
  },

  {
    'QuantEcon/myst-markdown-tree-sitter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('myst-markdown').setup()
    end,
  },

  'lervag/vimtex',

  -- Unify tmux and vim split motion.  The set of mappings is visible
  -- in the relevant section of the tmux config file.
  --
  -- As of Feb 2025 (commit 05fa2b1), the plugin adds tnoremap mappings
  -- that use Vim's <C-w> to escape terminal mode. This doesn't work in
  -- Neovim — the command string leaks into the shell as literal text.
  -- We disable all default mappings here and define our own in keymaps.lua.
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      vim.g.tmux_navigator_no_mappings = true
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- LSP config
  --
  -- mason.nvim manages external tool installs (LSP servers, formatters, etc.).
  -- mason-tool-installer keeps a declared list of those tools installed; it
  -- replaces mason-lspconfig, which was a bridge to the old lspconfig setup
  -- API and is unnecessary now that we configure servers via vim.lsp.config.
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  -- Completion engine (async, multi-source). LuaSnip is pulled in as a dep
  -- so blink can drive snippet expansion/jumping via its luasnip preset.
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip' },
    version = '1.*',
  },


  -- colorscheme
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

}

local opts = {}

require('lazy').setup(plugins, opts)
