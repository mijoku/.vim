" setup pathogen:
call pathogen#infect()

" spaces and tabs:
set ts=2 sw=2 sts=2 smarttab expandtab
set smartindent       " 
set autoindent        " automatically indent line.

" user interface:
set title             " show title all the time.
set number            " show line numbers.
set relativenumber    " above and below current line, numbers are relative.
set ruler             " always show cursor.
set cursorline        " highlight currently selected line. 
set showcmd
filetype indent on
set wildmenu          " visual autocomplete for :!
syntax on             " enable syntax highlighting.
set wrap              " wrap lines.
set whichwrap+=<,>,b  " allow left and right arrow + backspace to travers eol (h+l still don't).
set encoding=utf8
set ffs=unix,dos,mac  " unix shall be the standard filetype.

" backups
set nobackup          " disable backups
set nowb
set noswapfile


" usability:
set hid               " change buffer without saving.
                      " set backspace to work as intended.
set backspace=eol,start,indent

" select colorscheme
colorscheme gruvbox
set background=dark   " select gruvbox's dark theme (light is default).

" search options:
set ignorecase        " ignore case when searching.
set smartcase         " try to be smart about case when searching.
set hlsearch          " highlighted search.
set lazyredraw        " redraw only when vim needs to.
set showmatch         " show matching brackets when text indicator is over them.
set magic             " enable regular expressions.
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

" terminal
nnoremap <silent> ,t :terminal<CR>

