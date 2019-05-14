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
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

""""""""" My Added Plugins """"""""""
Plugin 'Yggdroot/duoduo'
Plugin 'rakr/vim-one'
Plugin 'altercation/vim-colors-solarized'
Plugin 'beigebrucewayne/Turtles'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'majutsushi/tagbar'
Plugin 'posva/vim-vue'
Plugin 'scrooloose/nerdcommenter'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'chase/vim-ansible-yaml'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'mxw/vim-jsx'
Plugin 'mattn/emmet-vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jiangmiao/auto-pairs'

"""""""""""""""""""""""""""""""""""""


" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""common settings"""""""""""""""""""
" syntax highlighting on
syntax on
"""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""setting color theme"""""""""""""""
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set t_Co=256
colorscheme one
" set background=dark " for the light version
set background=light " for the light version
let g:airline_theme='one'
""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""Indent settings""""""""""""""""""""""""""
" 4 spaces for tabs for python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
" 4 spaces for tabs for C
autocmd Filetype c setlocal expandtab tabstop=4 shiftwidth=4
" 2 spaces for tabs for bash
autocmd Filetype sh setlocal expandtab tabstop=2 shiftwidth=2
" 2 spaces for tabs for ruby
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2
" 4 spaces for tabs for html
autocmd Filetype html setlocal tabstop=4 shiftwidth=4
" 2 spaces for tabs for javascript
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""" disable swapfile """"""
set noswapfile
""""""""""""""""""""""""""""""


"""""" highlight trailing whitespace """"""
match ErrorMsg '\s\+$'
"""""""""""""""""""""""""""""""""""""""""""

"""""" highlight tabs with '>-' symbols """"""
set list
set listchars=tab:.\.
""""""""""""""""""""""""""""""""""""""""""""""

"""""" LineNumbers settings """"""
set number
func ToggleNumber()
    set number!
endfunc
map <c-n> :call ToggleNumber()<cr>
"""""""""""""""""""""""""""""""""""

"""""" Nerdtree settings """"""
map <F2> :NERDTreeToggle<cr>
"""""""""""""""""""""""""""""""

"""""" Indent Python in the Google way. """""""""""""""""""""""""""""""""""

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <F3> :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_server_python_interpreter = "/usr/bin/python3"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable all Python syntax highlighting features
let python_highlight_all = 1


set expandtab
set tabstop=4
set shiftwidth=4


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python-mode cofigurations
"
let g:pymode_python = 'python3'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
