require("flash").setup({
  -- Labels to use for jump targets
  labels = "asdfghjklqwertyuiopzxcvbnm",

  -- Search configuration
  search = {
    -- Search mode: "exact", "search", "fuzzy"
    mode = "exact",
    -- Behave like `incsearch`
    incremental = false,
  },

  -- Jump configuration
  jump = {
    -- Jump to first match automatically
    jumplist = true,
    -- Jump position
    pos = "start",
    -- Add position to the jumplist
    history = false,
    -- Automatically jump when there is only one match
    autojump = false,
  },

  -- Label configuration
  label = {
    -- Allow uppercase labels (easier to hit for some people)
    uppercase = false,
    -- Show labels after the match
    after = true,
    -- Show labels before the match
    before = false,
    -- Position of the label
    style = "overlay",
  },

  -- Highlight configuration
  highlight = {
    -- Show a backdrop with hl FlashBackdrop
    backdrop = true,
    -- Highlight matches
    matches = true,
  },

  -- Default keybindings are set in keymaps.lua
  modes = {
    -- Use flash when doing a regular search with /
    search = {
      enabled = false,
    },
    -- Use flash for character motion (f, F, t, T)
    char = {
      enabled = false,
    },
  },
})
