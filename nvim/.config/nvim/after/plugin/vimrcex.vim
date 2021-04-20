augroup vimrcEx
  autocmd!

  " Jump to last cursor position unless it's invalid, in an event handler
  " or for commit messages (taken from $VIMRUNTIME/defaults.vim)
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

  " Unset paste on InsertLeave
  autocmd InsertLeave * silent! set nopaste
augroup END
