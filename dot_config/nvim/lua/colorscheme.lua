vim.cmd [[
try
  colorscheme wombat256mod
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
