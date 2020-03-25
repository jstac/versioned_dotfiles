"""
" John Stachurski's vimrc
"
" Plugin manager = vim-plug
"
"""


set runtimepath+=~/.vim

" let g:UltiSnipsSnippetsDir = "~/.vim/plugged/vim-snippets"
" let g:UltiSnipsSnippetDirectories = ['vim-snippets', 'UltiSnips']

let g:python_host_prog='/home/john/anaconda3/bin/python'

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Have installed the following extensions via CocInstall
" * coc-texlab
" * coc-python
" * coc-snippets
"
" Also, add the following, bit by bit: https://github.com/neoclide/coc.nvim#example-vim-configuration


" Snippets are separated from the engine. I'll use my fork of honza/vim-snippets.  
" This is the repo to edit when adding/changing snippets.  To keep things
" clean, perhaps clone it separately, edit, push changes and then PlugUpdate
Plug 'jstac/vim-snippets'

" Nice file icons
Plug 'ryanoasis/vim-devicons'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

set statusline^=%{coc#status()}

" Unicode characters (select and <ctrl-l> or <ctrl-l> in normal mode)
Plug 'joom/latex-unicoder.vim'

" Latex support
Plug 'lervag/vimtex'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Nerdtree (activated by <ctrl-t>, see below)
Plug 'preservim/nerdtree'

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


""""""""""""""" coc """"""""""""""""""""""""

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" <tab> and <S-tab> are used to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" <cr> confirms competion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"""""""""""""""" coc-snippets """""""""""""""

" Snippets are accessible through <tab> and navigation is by <tab> and <S-tab>


""""""""""""""" Nerdtree """"""""""""""""""""

nmap <C-t> :NERDTreeToggle<CR>


""""""""""""""" vimtex """"""""""""""""""""""

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

