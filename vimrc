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

" select colorscheme
colorscheme gruvbox
set background=dark   " select gruvbox's dark theme (light is default).

" search options:
set hlsearch          " highlighted search.
set incsearch         " do incremental searching. 

" NERDtree
nnoremap <silent> tt :NERDTreeToggle<CR>
nnoremap <silent> tf :NERDTreeFind<CR>

" tabs
function! OpenNewTab()
  call inputsave()
  let fn = input("File: ","","file")
  call inputrestore()
  exec 'tabnew '.fn
endfunction
nnoremap <silent> tn :call OpenNewTab()<CR>
nnoremap <silent> tc :tabclose<CR>
nnoremap <silent> tC :tabonly<CR>

