# Neovim Configuration

Personal Neovim configuration based on [cpow-dotfiles](https://github.com/cpow/cpow-dotfiles).

## Plugin Manager

Using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

## Installed Plugins

### Core Functionality
- **vim-fugitive** - Git integration
- **telescope.nvim** - Fuzzy finder for files, buffers, etc.
- **oil.nvim** - File explorer (edit filesystem like a buffer)
- **toggleterm.nvim** - Terminal integration
- **Comment.nvim** - Easy commenting with `gc` operator
- **vim-tmux-navigator** - Seamless navigation between tmux panes and vim splits

### LSP & Completion
- **mason.nvim** - LSP server manager
- **nvim-lspconfig** - LSP configuration
- **mason-lspconfig.nvim** - Bridge between mason and lspconfig
- **nvim-cmp** - Completion engine
  - **cmp-nvim-lsp** - LSP completion source
  - **cmp-buffer** - Buffer words completion
  - **cmp-path** - Path completion
- **LuaSnip** - Snippet engine
  - **cmp_luasnip** - LuaSnip completion source

### Syntax & Appearance
- **nvim-treesitter** - Advanced syntax highlighting
- **myst-markdown-tree-sitter.nvim** - MyST markdown support
- **vimtex** - LaTeX support
- **lualine.nvim** - Statusline
- **nvim-web-devicons** - File icons
- **everforest-nvim** - Colorscheme

## Language Servers

Using Neovim 0.11+ built-in LSP API (`vim.lsp.config`).

Configured LSP servers (auto-installed via mason):
- **texlab** - LaTeX
- **lua_ls** - Lua (with Neovim API support)

### LSP Features
- Autocompletion via nvim-cmp
- Hover documentation
- Go to definition/declaration
- Find references
- Rename symbols
- Code actions

### LSP Keybindings
These keybindings are available when an LSP server is attached to a buffer:

- `K` - Show hover documentation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show references
- `<leader>rn` - Rename symbol under cursor
- `<leader>ca` - Show code actions

**Useful commands:**
- `:LspInfo` - Show LSP server status
- `:Mason` - Manage LSP servers and other tools

## Snippets

Snippets are stored in `~/.config/nvim/snippets/` directory in SnipMate format.

### Available Snippet Files
- `tex.snippets` - LaTeX snippets (Greek letters, environments, etc.)
- `python.snippets` - Python snippets
- `julia.snippets` - Julia snippets
- `markdown.snippets` - Markdown snippets
- `rst.snippets` - reStructuredText snippets

### Using Snippets

**Basic Usage:**
1. In insert mode, type a snippet trigger (e.g., `alpha`)
2. Press **Tab** to expand the snippet
3. For snippets with placeholders, press **Tab** to jump to the next placeholder

**Example - Greek Letters (LaTeX):**
- Type `alpha` + Tab → `α`
- Type `beta` + Tab → `β`
- Type `lambda` + Tab → `λ`

**Example - LaTeX Environments:**
- Type `begin` + Tab → `\begin{env}...\end{env}` (cursor at `env`)
- Type environment name (e.g., `theorem`)
- Tab → jump to content area

### Completion Keybindings
- **Tab** - Select next completion item / expand or jump in snippet
- **Shift-Tab** - Select previous completion item / jump back in snippet
- **Enter** - Confirm completion selection
- **Ctrl-Space** - Trigger completion manually
- **Ctrl-e** - Abort completion
- **Ctrl-b** / **Ctrl-f** - Scroll documentation up/down

## Key Mappings

### Leader Keys
- Leader: `Space`
- Local leader: `\`

### General
- `jj` - Exit insert mode (alternative to Esc)
- `Q` - Format paragraph
- `Ctrl-n` - Next buffer

### Leader Mappings
- `<leader>w` - Save file
- `<leader>d` - Delete buffer
- `<leader><CR>` - Reload config
- `<leader>st` - Toggle spell check
- `<leader>rn` - Rename symbol (LSP)
- `<leader>ca` - Code actions (LSP)

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags

### Oil (File Explorer)
- `-` - Open parent directory
- `<space>-` - Open parent directory in floating window

### ToggleTerm (Terminal)
- `<leader>av` - Open vertical terminal (68 columns)
- `<leader>ah` - Open horizontal terminal (8 rows)
- `<leader>af` - Open floating terminal
- `<leader>sl` - Send current line to terminal
- `<leader>ss` - Send visual selection to terminal (visual mode)

### Terminal Mode
- `Ctrl-\ Ctrl-\` - Exit terminal mode to normal mode
- `Ctrl-h` / `Ctrl-l` - Navigate between splits (even in terminal mode)

### Tmux Integration
- `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` - Navigate between vim splits and tmux panes

## Configuration Structure

```
nvim/
├── init.lua                    # Entry point
├── lua/core/
│   ├── options.lua            # Vim options
│   ├── keymaps.lua            # Key mappings
│   ├── plugins.lua            # Plugin specifications
│   ├── colorscheme.lua        # Colorscheme settings
│   └── plugin_config/         # Plugin-specific configurations
│       ├── init.lua           # Loads all plugin configs
│       ├── cmp.lua            # Completion setup
│       ├── lsp_config.lua     # LSP configuration
│       ├── lualine.lua        # Statusline
│       ├── oil.lua            # File explorer
│       ├── telescope.lua      # Fuzzy finder
│       ├── toggleterm.lua     # Terminal
│       ├── treesitter.lua     # Syntax highlighting
│       ├── vimtex.lua         # LaTeX support
│       ├── myst-markdown.lua  # MyST markdown
│       └── nvim-web-devicons.lua
└── snippets/                  # Snippet files (SnipMate format)
    ├── tex.snippets
    ├── python.snippets
    ├── julia.snippets
    ├── markdown.snippets
    └── rst.snippets
```

## Notable Settings

- Tab width: 4 spaces
- Auto-indent enabled
- Line width: 80 characters
- Incremental search: disabled
- Splits: open below and right (more natural)
- Fold method: indent (with level 99, so files open unfolded)
- Hidden buffers: enabled (can switch buffers without saving)

## Installation

1. Clone this config to `~/.config/nvim/`
2. Open Neovim
3. lazy.nvim will auto-install on first run
4. Run `:Lazy sync` to install all plugins
5. LSP servers will auto-install via mason when you open relevant file types

## Updating

- `:Lazy sync` - Update all plugins
- `:Mason` - Manage LSP servers
