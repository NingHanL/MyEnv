set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'python-mode/python-mode'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'Yggdroot/indentLine'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'jeetsukumaran/vim-buffergator'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Nerdtree settings
map <F2> :NERDTreeToggle<cr>

" NerdCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" neocomplcache settings
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

" LineNumbers settings
set number
func ToggleNumber()
	set number!
endfunc
map <c-n> :call ToggleNumber()<cr>

" gitgutter settings
set updatetime=250

" indent settings
" 4 spaces for tabs for python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
" 4 spaces for tabs for C
autocmd Filetype c setlocal expandtab tabstop=4 shiftwidth=4
" 2 spaces for tabs for bash
autocmd Filetype sh setlocal expandtab tabstop=2 shiftwidth=2

" disable folding
set nofoldenable

" hightlight search results
set hlsearch

" show matchbrackets
set showmatch

" set 80 column border for good coding style
" set cc=80

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
set t_Co=256

" TagBarToggle
nmap <F3> :TagbarToggle<CR>

" ctrlp setttings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" split navigations ctrl + [h,j,k,l]
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 80 characters ruler
highlight ColorColumn ctermbg=gray
set colorcolumn=80

" disable swapfile
set noswapfile

" highlight trailing whitespace
match ErrorMsg '\s\+$'
" delete trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" highlight tabs with '>-' symbols
set list
set listchars=tab:.\.
func ToggleList()
    set list!
endfunc
map <c-l> :call ToggleList()<cr>


nnoremap <Leader>rt :retab<CR>
