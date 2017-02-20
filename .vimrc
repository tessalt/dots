set nocompatible              " be iMproved, required
filetype off

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

" remapped keybindings
nnoremap gb gT

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


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
let g:ctrlp_custom_ignore = 'node_modules/\|build\|DS_Store\|bundle\|lib\|dist'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_files = 0

" no swap files"
set nobackup
set nowritebackup
set noswapfile

syntax on
syntax enable

colorscheme quantum
let g:quantum_black = 1
let g:airline_theme='quantum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>


set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase


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

set laststatus=2 " airline
set ttimeoutlen=50 "airlin
" Airline.vim


augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

execute pathogen#infect()
filetype plugin indent on    " required
