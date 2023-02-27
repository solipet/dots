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
colorscheme solipet
" colorscheme solarized

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

" Save LOTS of history!
set history=500

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Strip trailing whitespaces and keep new line at the end of file
" https://gist.github.com/jandudulski/4451806
if has("autocmd")
  " remove trailing white spaces
  autocmd BufWritePre * :%s/\s\+$//e
endif

" In MacVim, you can have multiple tabs open. This mapping makes
" ctrl-tab switch between them, like browser tabs.
" I don't think it matters whether I use noremap or map, unless
" :tabnext gets bound to something else, which would be weird.
noremap <c-tab> :tabnext<cr>

" Jump to the tag under the cursor when the tag is double clicked
"   from: http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" :nnoremap <2-LeftMouse> :exe "tag ". expand("<cword>")<CR>

" Regenerate ctags, including gems
"   from: http://stackoverflow.com/questions/4539265/regenerate-ctags-in-vim-using-rvm
map <Leader>rt :!/usr/local/bin/ctags --language-force=ruby --exclude=.git --exclude=log -R * `bundle show --paths`

set laststatus=2

cmap w!! w !sudo tee > /dev/null %

" inserts some debugging code to puts the caller.
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" Highlight all emdashes in red
highlight Emdash ctermbg=red guibg=red
match Emdash /–\+/
autocmd BufWinEnter * match Emdash /–\+/
autocmd InsertEnter * match Emdash /–\+\%#\@<!/
autocmd InsertLeave * match Emdash /–\+/
autocmd BufWinLeave * call clearmatches()

" Enable fzf
set rtp+=/usr/local/opt/fzf
" open the fuzzy file finder
nnoremap <leader>oo :FZF<cr>
