
-- General keymaps that are not pluggin dependant
--

local Utils = require('utils')

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap

-- jj to normal mode
inoremap("jj", "<Esc>")
