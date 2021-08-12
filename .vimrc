""""""""""""" John Stachurski's vimrc """""""""""""""
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugin manager = vim-plug
set runtimepath+=~/.vim
call plug#begin('~/.vim/plugged')  " Specify a directory for plugins

""" Using tab for omnicomplete
Plug 'ervandew/supertab'

""" Snippets 
Plug 'SirVer/ultisnips'     " Expand snippets with <c-k>, see below.  
Plug 'jstac/vim-snippets'   " edit snippets. Fork of honza/vim-snippets.  

""" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"""" Unicode characters 
Plug 'joom/latex-unicoder.vim'  " select and <c-a> or <c-a> in normal mode, see below

"""" Latex support
Plug 'lervag/vimtex'

"""" Commenting
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



""""""""""""" Colorscheme """""""""""""""""""""""""

set t_Co=256
set t_ut=
"colorscheme OceanicNext
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


"""""""""""""""""" General maps  """""""""""""""""""""""""""""

" map of maps
imap jj <Esc>
" Q is format paragraph
map Q {gq}


""""""""""""""""" Leader and related """""""""""""""""""""""

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>     
nnoremap <Leader>d :bd<CR>   


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

let g:vimtex_view_method = 'mupdf'

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


""""""""""""""" latex-unicoder """"""""""""""""

let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <C-a> :call unicoder#start(0)<CR>
inoremap <C-a> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-a> :<C-u>call unicoder#selection()<CR>

""""""""""""""" Python stuff  """""""""""""""""

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


"""" Ultisnips """"""""

" Trigger
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Snippet location
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']


