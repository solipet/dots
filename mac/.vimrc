" Load Pathogen
execute pathogen#infect()

"" Whitespace
"set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

" Stop creating .swp files!
set nobackup
set nowritebackup
set noswapfile

" Force file format to always be unix.  If it's allowed to auto-detect
" it will hide all the ^M's because it will think it's a dos file
"set fileformats=mac,unix,dos
set fileformats=unix

" Fix common spelling mistakes
abbreviate teh the
abbreviate Teh The
abbreviate recieve receive
abbreviate Recieve Receive
abbreviate transcieve transceive
abbreviate Transcieve Transceive

set background=dark

" Highlight matches to the search
set hlsearch

" Highlight first match of search while typing it
set incsearch

" Do syntax highlighting
syntax on

" Show matching braces when cursor is over them
set showmatch

" Show line numbers
set nu

filetype plugin indent on

let mapleader = ","
nnoremap <silent> <Leader>b :TagbarToggle<CR>
