" visual.vim

" Enable syntax highlighting
syntax on

" Line numbers on
set number
" Enable relative number for line
" (Constantly computing the relative nubmers is expensive)
set relativenumber
" Check if oni neovim gui is used
if exists("g:gui_oni")
  " Do not show ruler
  set noruler
  " Never show tab pannel
  set showtabline=0
  " Do not show command typing
  set noshowcmd
  " Never show status line
  set laststatus=0
else
  " Show ruler
  set ruler
  " Always show tab pannel
  set showtabline=2
  " Show command typing
  set showcmd
  " Native customized statusline, if airline is not available
  set statusline=%1*%{winnr()}\ %*%<\ %f\ %h%m%r%=%l,%c%V\ (%P)
  " Always show status line.
  set laststatus=2
endif
" Show matching brackets
set showmatch
" Bracket blinking
set matchtime=5
" Hide the current mode
set noshowmode
" Mark 80th column with a highlight color
if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn ctermbg=gray
endif
" Highlight current line
set cursorline
" Show cursorline for active window only
augroup highlight_active_window
  autocmd!
  autocmd BufEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
augroup END
" No blinking
set novisualbell
" No noise
set noerrorbells
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3
" No conceal
set conceallevel=0
" Use a block cursor in normal mode, i-beam cursor in insertmode
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

""" Match and search {{{
  " Highlight searches
  set hlsearch
  " Ignore case of searches
  set ignorecase
  " be sensitive when there's a capital letter
  set smartcase
  " Highlight dynamically as pattern is typed
  set incsearch
""" }}}
