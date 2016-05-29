set nocompatible              " be iMproved, required
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'duythinht/vim-coffee'
Plugin 'scrooloose/nerdTree'
call vundle#end()            " required
filetype plugin indent on    " required

execute pathogen#infect()

set runtimepath^=~/.vim/bundlet/ctrlp.vim

let mapleader=";"

" NERDTree
nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
let NERDTreeShowHidden=1
"
" " quit NERDTree after opening a file
let g:NERDTreeQuitOnOpen = 0
set clipboard=unnamed


function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" CtrlP
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = 'build'
let g:ctrlp_custom_ignore = 'node_modules/'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" no swap files"
set nobackup
set nowritebackup
set noswapfile

syntax on
" set background=dark
" colorscheme solarized
set showmatch
hi MatchParen cterm=none ctermbg=DarkGreen ctermfg=black
highlight Comment ctermfg=darkblue
set colorcolumn=120
highlight ColorColumn ctermbg=grey
:hi TabLineSel ctermfg=black ctermbg=darkgreen


filetype plugin indent on
set number " show line numbers
set backspace=2 " make backspace work like most other apps
set nowrap " dont visually wrap lines
" tabbing "
set smartindent " indent new lines appropriately
set smarttab "
set tabstop=2 " tab 2 spaces
set shiftwidth=2 " shift 2 spaces when doing << or >>
set expandtab " spaces instead of tab characters

set hidden


" something to delete trailing white space "
autocmd BufWritePre *.js :%s/\s\+$//e

