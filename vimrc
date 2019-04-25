" setup pathogen:
call pathogen#infect()

" spaces and tabs:
set ts=2 sw=2 sts=2 smarttab expandtab

" user interface:
set title             " show title all the time.
set number            " show line numbers.
set relativenumber    " above and below current line, numbers are relative.
set ruler             " always show cursor.
set cursorline        " highlight currently selected line. 
set showcmd
filetype indent on
set wildmenu          " visual autocomplete for :!
set lazyredraw        " redraw only when vim needs to.
set showmatch
syntax on             " enable syntax highlighting.
set autoindent        " automatically indent line.

" usability:
set hid               " change buffer without saving.

" make dracula the default colorscheme:
colorscheme dracula

" search options:
set hlsearch          " highlighted search.
set incsearch         " do incremental searching. 
