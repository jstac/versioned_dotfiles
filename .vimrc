"""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"
""""""""""""" John Stachurski's vimrc """""""""""""""
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""


"""" preamble
"
" Plugin manager = vim-plug
"
set runtimepath+=~/.vim
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

"""" Code completion (currently disabled)
"
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


""" Snippets
"
Plug 'SirVer/ultisnips'
"
" Snippets are separated from the engine. I'll use my fork of honza/vim-snippets.  
" This is the repo to edit when adding/changing snippets.  To keep things
" clean, perhaps clone it separately, edit, push changes and then PlugUpdate
Plug 'jstac/vim-snippets'


""" Status line
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"""" Unicode characters 
"
" (select and <ctrl-l> or <ctrl-l> in normal mode)
Plug 'joom/latex-unicoder.vim'

"""" Latex support
"
Plug 'lervag/vimtex'

"""" Commenting
"
Plug 'scrooloose/nerdcommenter'

" Colors
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

" Initialize plugin system
call plug#end()




"""""""""""""" Basic preferences """""""""""""""

"set background=dark
set showmode              " show da mode
set bs=2                  " backspace over everything
set incsearch
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



""""""""""""" Colorscheme """""""""""""""""""""""""

set t_Co=256
set t_ut=
colorscheme OceanicNext
"colorscheme nord
colorscheme wombat256mod
"colorscheme gruvbox
"colorscheme codedark
"colorscheme janah
"colorscheme challenger-deep
syntax on




"""""""""""" Splits """"""""""""""""""""

" More natural splits (new splits are below or on right)
"
set splitbelow
set splitright


"""""""""""" Buffers """"""""""""""""""""

" Moving between buffers
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>



""""""""""""""""" General maps  """""""""""""""""""""""""""""

" map of maps
imap jj <Esc>
" Q is format paragraph
map Q {gq}


""""""""""""""""" Leader and related """""""""""""""""""""""

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>d :bd<CR>
"nnoremap <Leader>q :wq<CR>


"""""""""""""""""" Function key maps """""""""""""""""""""""

" Spelling on 
map <F2> <Esc>:setlocal spell spelllang=en_us<CR>
" Spelling off 
map <F3> <Esc>:setlocal nospell<CR>
" Toggle paste on and off
map <F4> :set invpaste<CR>
" Toggle line numbers
map <F5> :set invnumber<CR>




""""""""""""""" vimtex """"""""""""""""""""""

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'mupdf'

let g:vimtex_quickfix_latexlog = {
  \ 'font' : 0,
  \ 'overfull' : 0,
  \ 'underfull' : 0,
  \ 'warning' : 0
\}

let g:vimtex_compiler_latexmk = {
    \ 'background' : 1,
    \ 'build_dir' : '',
    \ 'callback' : 0,  
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-pdf',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
\}


"""" Ultisnips """"""""

" Triggered by <tab> (conflicts with YouCompleteMe, completion-nvim, " etc.)
let g:UltiSnipsExpandTrigger="<tab>"
" Forward and backward
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Snippet location
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']

"""""""""""""" Restructured Text """"""""""""""""

" associate *.tmpl with rst filetype
au BufRead,BufNewFile *.tmpl set filetype=rst


"""""""""""""" python stuff  """""""""""""""""

autocmd FileType python set smartindent 


""""""""""""""" line numbers """"""""""""""""""""""

autocmd FileType python set number  
autocmd FileType c set number  
autocmd FileType julia set number  



"""""""""""""""" Other stuff """""""""""""""""""

" low priority to these files in file name expansion 

set suffixes+=.aux
set suffixes+=.out
set suffixes+=.dvi
set suffixes+=.log
set suffixes+=.pdf
set suffixes+=.ps

