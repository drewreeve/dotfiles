" enable pathogen
call pathogen#infect()

set nocompatible
set ruler
set number
set expandtab
set tabstop=2
set shiftwidth=2
set history=10000
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase
" highlight current line
set cursorline
set cmdheight=2
set numberwidth=5
set winwidth=82
" display incomplete commands
set showcmd

" enable syntax highlighting
syntax on
" Colors
:set t_Co=256 " 256 colors
:set background=dark
:color solarized

filetype plugin indent on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

"for ruby, autoindent with two spaces, always expand tabs
autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

let mapleader=","

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status line (from gary bernhardt https://github.com/garybernhardt/dotfiles)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
