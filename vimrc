" ----------------------------------------------------------------------------
"  Load Plugins
" ----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" ----------------------------------------------------------------------------
" Load builtin matchit.vim unless there's a newer version
" ----------------------------------------------------------------------------
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ----------------------------------------------------------------------------
"  Basic Settings
" ----------------------------------------------------------------------------

let mapleader=","

if has('autocmd')
  filetype plugin indent on
endif

" allow unsaved background buffers and remember marks/undo for them
set hidden
set ruler " always show cursor position
set number relativenumber
set history=1000
set autoindent
set laststatus=2
set nojoinspaces
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
set wildmode=longest,list
set wildmenu " make tab completion for files/buffers act like bash

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

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

" Store temporary files in a central spot
set backupdir=~/.vim/tmp//,~/tmp//,/tmp//
set directory=~/.vim/tmp//,~/tmp//,/tmp//

" Autocomplete dictionary words if spell check is on
set complete+=kspell

let g:html_indent_tags = 'li\|p'

" ----------------------------------------------------------------------------
" Colors and syntax highlighting
" ----------------------------------------------------------------------------
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
set background=dark
colorscheme gruvbox

" ----------------------------------------------------------------------------
"  AutoCMD's
" ----------------------------------------------------------------------------
augroup vimrcEx
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
  autocmd InsertLeave * silent! set nopaste

  " Automatic rename of tmux window
  " borrowed from http://github.com/junegunn/dotfiles
  if exists('$TMUX') && !exists('$NORENAME')
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" ----------------------------------------------------------------------------
" Searching & fzf
" ----------------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Replicate default behaviour of ctrlp
nnoremap <silent> <c-p> :GFiles -co --exclude-standard<cr>
nnoremap <silent> <Leader>f :Files<cr>
nnoremap <silent> <Leader>ag :Ag<cr>

" Use The Silver Searcher  https://github.com/ggreer/the_silver_searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ----------------------------------------------------------------------------
" Status line
" ----------------------------------------------------------------------------
set statusline=
set statusline+=%<                   " truncate point
set statusline+=%f                   " relative path to file
set statusline+=\ %m                 " modified flag [+], [-] etc.
set statusline+=%r                   " readonly flag [RO]
set statusline+=\ (%{&ft})           " filetype (ruby)
set statusline+=%=                   " switch to right side
set statusline+=%-14.(%3l,%02c%03V%) " current line, column/virtual column
set statusline+=\ %P                 " percentage through file

" ----------------------------------------------------------------------------
" Smart tab key (borrowed from gary bernhardt)
" inserts tabs at the beginning of lines, otherwise does completion
" ----------------------------------------------------------------------------
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" ----------------------------------------------------------------------------
" Dispatch settings
" ----------------------------------------------------------------------------
let g:dispatch_compilers = {
      \ 'bundle exec': '',
      \ 'clear;': '',
      \ 'zeus': ''}

" ----------------------------------------------------------------------------
" Vim-test
" ----------------------------------------------------------------------------
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

let test#strategy = "dispatch"

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

" Clear highlighted searches
nnoremap <silent> <leader>c :nohlsearch<CR>

" insert hashrocket with <c-l>
imap <c-l> <space>=><space>

" Escape insert mode with jk
inoremap jk <Esc>

" Switch between last 2 files
nnoremap <leader><leader> <c-^>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" grep word under cursor
nnoremap K :set nois<CR> :Ag <C-R><C-W><CR>

" ----------------------------------------------------------------------------
" Additional Nvim Settings
" ----------------------------------------------------------------------------
if has("nvim")
  " Use different cursor in insert mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" ----------------------------------------------------------------------------
" True Color stuff
" ----------------------------------------------------------------------------
if filereadable($HOME . "/.true_color")
  " In nvim just set termguicolors and we're good to go
  if has("nvim")
    if has('termguicolors')
      set termguicolors
    endif
  else
    if has('termguicolors')
      set termguicolors

      " Vim sets these automatically in xterm* but tmux $TERM is now set to
      " screen* as recommended by the author. Thus we have to fix that here.
      if &term =~# 'screen-256color'
        let &t_8f="\e[38;2;%ld;%ld;%ldm"
        let &t_8b="\e[48;2;%ld;%ld;%ldm"
      endif
    endif
  endif
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source $HOME/.vimrc.local
endif
