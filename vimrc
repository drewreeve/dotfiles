set nocompatible

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load builtin matchit.vim unless there's a newer version
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

" allow unsaved background buffers and remember marks/undo for them
set hidden
set ruler " always show cursor position
set number relativenumber
set history=1000
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set showcmd " display incomplete commands
set backspace=indent,eol,start
set scrolloff=3
set autoread
set nofoldenable
set ttyfast
set lazyredraw " helps with performance on my aging iMac

" Open new split panes to right and bottom
set splitbelow
set splitright

" Highlight where 80 characters is
set textwidth=80
set colorcolumn=+1

" use softtabs (2 of course)
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

" Colors and syntax highlighting
syntax on
set background=dark
colorscheme gruvbox

set wildmode=longest,list

" make tab completion for files/buffers act like bash
set wildmenu

" ignore vendor/bundle directory in bundler projects
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.GIF,*.gif,vendor/bundle/**,tmp/**

let mapleader=","

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

augroup vimrcEx
  " clear all autocmds in group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax for certain file types
  autocmd BufNewFile,BufRead Guardfile,.Guardfile set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile zprofile set filetype=zsh

 " Run neomake when buffer is saved
  autocmd BufWritePost * Neomake

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Searching & fzf
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
endif

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Replicate default behaviour of ctrlp
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <Leader>ag :Ag<cr>

" Switch between last 2 files
nnoremap <leader><leader> <c-^>

" Store temporary files in a central spot
set backupdir=~/.vim/tmp//,~/.tmp//,~/tmp//,/tmp//
set directory=~/.vim/tmp//,~/.tmp//,~/tmp//,/tmp//

" Status line
set statusline=
set statusline+=%<         " truncate point
set statusline+=%f         " relative path to file
set statusline+=\ %m       " modified flag [+], [-] etc.
set statusline+=%r         " readonly flag [RO]
set statusline+=\ %y       " filetype [ruby]
set statusline+=%=         " switch to right side
set statusline+=L:%l\/%L   " current line/total lines
set statusline+=\ C:%c     " current column number

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
" insert hashrocket with <c-l>
imap <c-l> <space>=><space>

" Escape insert mode with jk
inoremap jk <Esc>

" Arrow keys are unacceptable
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Smart tab key (borrowed from gary bernhardt)
" inserts tabs at the beginning of lines, otherwise does completion
function! InsertTabWrapper()
    let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<tab>"
        else
            return "\<c-p>"
        endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

let g:html_indent_tags = 'li\|p'

" Close buffer without closing window/split
nnoremap <silent> <leader>bd :bp\|bd #<cr>
command Bd bp\|bd \#

" Vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

let test#strategy = "dispatch"

" Dispatch settings
let g:dispatch_compilers = {
      \ 'bundle exec': '',
      \ 'clear;': '',
      \ 'zeus': ''}

" Autocomplete dictionary words if spell check is on
set complete+=kspell

" Use different cursor in insert mode in neovim
if has("nvim")
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source $HOME/.vimrc.local
endif
