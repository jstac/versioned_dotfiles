-- Lazy set up

require('lazy').setup({

    'ervandew/supertab',

  {
    'akinsho/toggleterm.nvim', 
     version = "*", 
     config = true
  }, 

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
      dependencies = { 'nvim-lua/plenary.nvim' }
  }, 

  { -- favorite
    'michalbachowski/vim-wombat256mod', 
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
    
  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

}, {})
