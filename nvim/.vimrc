" ================================================= "
 
"           John Stachurski's vim config
 
" ================================================= "


""""""""""""" Manage plugins """"""""""""""""""""""""

" Plugin manager = vim-plug 
set runtimepath+=~/.vim
call plug#begin('~/.vim/plugged')  

"Syntaxrange
Plug 'inkarkat/vim-SyntaxRange'

"Ghosttext
Plug 'subnut/nvim-ghost.nvim', {'do': ':call nvim_ghost#installer#install()'}

" Julia
Plug 'JuliaEditorSupport/julia-vim'

""" Using tab for omnicomplete
Plug 'ervandew/supertab'

""" Snippets 
Plug 'SirVer/ultisnips'     " Expand snippets with <c-k>, see below.  
Plug 'jstac/vim-snippets'   " edit snippets. Fork of honza/vim-snippets.  

""" Status line
 Plug 'itchyny/lightline.vim'

""" Send code to a terminal
Plug 'jpalardy/vim-slime'

"""" Unicode characters 
Plug 'joom/latex-unicoder.vim'  " select and <c-k> or <c-k> in normal mode, see below

"""" Latex support
Plug 'lervag/vimtex'

"""" Commenting
Plug 'scrooloose/nerdcommenter'

"""
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colors
Plug 'rebelot/kanagawa.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'nightsense/vimspectr'
Plug 'tomasiser/vim-code-dark'
Plug 'gregsexton/Atom'
Plug 'dracula/vim'
Plug 'nanotech/jellybeans.vim'
Plug 'mhinz/vim-janah'
Plug 'arcticicestudio/nord-vim'
Plug 'michalbachowski/vim-wombat256mod'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-moonfly-colors'

" Initialize plugin system
call plug#end()





" ================================================ "
"             General configuration 
" ================================================ "



"""""""""""""" Basic preferences """""""""""""""""

"set background=dark
set showmode              " show da mode
set bs=2                  " backspace over everything
set noincsearch           " incremental search (sucks)
set hlsearch              " highlight search matches
set textwidth=78
set vb t_vb=              " flash screen instead of beep
set showmatch             " shows matching parenthesis
set tabstop=4             " no. of spaces when press tab
set expandtab             " tabs expanded into spaces
set shiftwidth=4
set smarttab 
set autoindent            " use current level of indent in next line
set wildmode=longest,list " bash-like tab completion when opening files
set hidden                " can open new files w/o saving existing
set foldmethod=indent
set foldlevel=99
set formatoptions=tqn


" vimtex requires this
filetype plugin indent on
syntax enable

""""""""""""" Colorscheme """""""""""""""""""""""""

set t_Co=256
set t_ut=
"colorscheme kanagawa
"colorscheme OceanicNext
"colorscheme nord
"colorscheme tokyonight
colorscheme wombat256mod
"colorscheme onedark
"colorscheme gruvbox
"colorscheme codedark
"colorscheme janah
"colorscheme challenger-deep

syntax on   " syntax highlighting

" Enable true colors
if exists('+termguicolors')
  " Necessary when using tmux
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Enable italics, Make sure this is immediately after colorscheme
" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
highlight Comment cterm=italic gui=italic


""""""""""""""" General maps  """""""""""""""""""""""

" map of maps
imap jj <Esc>
" Q is format paragraph
map Q {gq}

map <C-n> :bnext<CR>


""""""""""""""""" Leader and related """""""""""""""

let mapleader = "\<Space>"
let maplocalleader = "\\"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>d :bd<CR>


"""""""""""""""""" Function key maps """""""""""""""

" Spelling on 
map <F2> <Esc>:setlocal spell spelllang=en_us<CR>
" Spelling off 
map <F3> <Esc>:setlocal nospell<CR>
" Toggle paste on and off
map <F4> :set invpaste<CR>
" Toggle line numbers
map <F5> :set invnumber<CR>


"""""""""""""""""""""" Splits """"""""""""""""""""

" More natural splits (new splits are below or on right)
"
set splitbelow
set splitright



"""""""""" Terminal within vim """"""""""""""""""""

" Escape in the terminal
tnoremap jk <C-\><C-n>


""""""""""""""" Python stuff  """""""""""""""""

autocmd FileType python set smartindent 

" For handling myst files -- use Python syntax, trick neoterm 
" into sending code to IPython
" au BufReadPost *.md set syntax=python
" au VimEnter,BufRead,BufNewFile *.md set filetype=python


""""""""""""""" line numbers """"""""""""""""""""""

autocmd FileType python set number  
autocmd FileType c set number  
autocmd FileType julia set number  


"""""""""""""""" Other stuff """"""""""""""""""""""

" low priority to these files in file name expansion 

set suffixes+=.aux
set suffixes+=.out
set suffixes+=.dvi
set suffixes+=.log
set suffixes+=.pdf
set suffixes+=.ps




" ================================================= "
"""""""""""""" Plugin configuration """"""""""""""""
" ================================================= "


"""""""""""""""""" ultisnips """""""""""""""""""""""

" Trigger
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Snippet location
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']


"""""""""""""""" fzf """""""""""""""""""""""""""""""

let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5 } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
" Include hidden (dotfiles), ignore .gitignore files, .git/* files
let $FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

nmap <leader>f :Files<cr>



"""""""""""""""""" vimtex """"""""""""""""""""""""""

" vimtex uses the <localleader> for compiling, etc.  
" For example, <localleader>ll means compile
"

let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

" Currently suppressing all warnings, which is a little dangerous
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'continuous' : 0,
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}



""""""""""""""""" latex-unicoder """"""""""""""""""

let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <C-l> :call unicoder#start(0)<CR>
inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-l> :<C-u>call unicoder#selection()<CR>


""""""""""""""""" vim-slime """""""""""""""""""""""

" vim-slime sends selected area to tmux window with C-c-c
"
" Note: jalvesaq/vimcmdline is an alternative

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

" The following puts `%cpaste -q` at the start of the paste whenever
" ft=python.  This solves the indent problem when pasting into ipython.
let g:slime_python_ipython=1
