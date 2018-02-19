"""
" John Stachurski's vimrc
"
"""


" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Snippets engine
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. I'll use my fork of honza/vim-snippets.  
" This is the repo to edit when adding/changing snippets.  To keep things
" clean, perhaps clone it separately, edit, push changes and then PlugUpdate
Plug 'jstac/vim-snippets'

" Unicode characters (see :h unicode-plugin)
"
" Marginally useful.  :Digraphs eta shows the diagraph for eta, then use <C-k>
Plug 'chrisbra/unicode.vim'

" Latex support
Plug 'lervag/vimtex'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Supertab
Plug 'ervandew/supertab'

" Colors
Plug 'nightsense/vimspectr'
Plug 'tomasiser/vim-code-dark'
Plug 'gregsexton/Atom'
Plug 'dracula/vim'
Plug 'nanotech/jellybeans.vim'

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

set foldmethod=indent
set foldlevel=99
set formatoptions=tqn



""""""""""""" Colorscheme """""""""""""""""""""""""

set t_Co=256
set t_ut=
colorscheme codedark
syntax on



"""""""""""" Splits """"""""""""""""""""

" More natural splits (new splits are below or on right)
"
set splitbelow
set splitright

" Moving between splits
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>





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


""""""""""""""" ultisnips """"""""""""""""""

let g:UltiSnipsExpandTrigger="<c-l>"


""""""""""""""" vimtex """"""""""""""""""""""

let g:vimtex_view_method = 'mupdf'

let g:vimtex_quickfix_latexlog = {
  \ 'font' : 0,
  \ 'overfull' : 0,
  \ 'underfull' : 0
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

