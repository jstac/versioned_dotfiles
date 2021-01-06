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

"""" Code completion through coc --- I dropped this because it was too 
" heavy, slow and unreliable with large documents.
"
" Provides all forms of tab completion.  See settings below.
"
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
"  Extensions added through :CocInstall coc-snippets
"
"     :CocInstall coc-snippets


""" Using tab for omnicomplete
Plug 'ervandew/supertab'


""" Snippets 
"
" Expand snippets with <c-k> as per settings below.  Typical
" workflow is to tab expand the trigger word (uses coc) and
" then hit <c-k> to invoke ultisnips.
"
Plug 'SirVer/ultisnips'
"
" This is the repo to edit when adding/changing snippets. 
" Plug 'honza/vim-snippets'  
Plug 'jstac/vim-snippets'   " A fork of honza/vim-snippets.  


""" Status line
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"""" Unicode characters 
"
" (select and <c-l> or <c-l> in normal mode)
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

let g:vimtex_view_method = 'mupdf'

let g:tex_flavor = 'latex'

" Currently suppressing all warnings, which is a little dangerous
let g:vimtex_quickfix_open_on_warning = 0

" This isn't working well so killed it
"
"let g:vimtex_quickfix_latexlog = {
"  \ 'Font' : 0,
"  \ 'Overfull' : 0,
"  \ 'Underfull' : 0,
"  \ 'Warning' : 0
"\}
"

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

"let g:vimtex_compiler_latexmk = {
    "\ 'background' : 1,
    "\ 'build_dir' : '',
    "\ 'callback' : 0,  
    "\ 'executable' : 'latexmk',
    "\ 'options' : [
    "\   '-pdf',
    "\   '-verbose',
    "\   '-file-line-error',
    "\   '-synctex=1',
    "\   '-interaction=nonstopmode',
    "\ ],
"\}



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


"""" Ultisnips """"""""

" Trigger
let g:UltiSnipsExpandTrigger="<C-k>"
" Forward and backward
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Snippet location
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']


"""" coc """""""""""""""

" trigger completion with <tab>
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
    "\ pumvisible() ? "\<C-n>" :
    "\ <SID>check_back_space() ? "\<TAB>" :
    "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


"" After :CocInstall coc-snippets, based on information from
"" https://www.chrisatmachine.com/Neovim/17-snippets/
""
"" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)
"" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)
"" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<c-j>'
"" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-k>'
"" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)

