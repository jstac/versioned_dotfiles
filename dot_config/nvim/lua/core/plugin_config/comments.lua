-- requre https://github.com/numToStr/Comment.nvim
require('Comment').setup()

-- under default setup, select block and use gc to toggle
--
-- More details from docs
--
-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment
-- `gc$` - Toggle from the current cursor position to the end of line
-- `gc}` - Toggle until the next blank line
-- `gc5j` - Toggle 5 lines after the current cursor position
-- `gc8k` - Toggle 8 lines before the current cursor position
-- `gcip` - Toggle inside of paragraph
-- `gca}` - Toggle around curly brackets
