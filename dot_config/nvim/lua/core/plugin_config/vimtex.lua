vim.g.vimtex_quickfix_mode = false
vim.g.vimtex_view_method = 'zathura'
vim.g.tex_flavor = 'latex'

vim.g.vimtex_compiler_latexmk = {
    executable = 'latexmk',
    continuous = 0,
    options = {
    "-pdfxe",
    "-shell-escape",
    "-synctex=1",
    "-g",
  },
}

