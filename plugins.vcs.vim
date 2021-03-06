" plugins.vcs.vim

"" Plugin: Vim Git {{{
  " For syntax highlighting and other Git niceties
  Plug 'tpope/vim-git'
"" }}}

"" Plugin: Vim Fugitive {{{
  " The best Git wrapper
  Plug 'tpope/vim-fugitive'
  " Always open splits Gdiff splits vertically
  set diffopt+=vertical
  " Key mappings for convenience
  nnoremap <Leader>gd :Gvdiff<CR>
  nnoremap <Leader>gD :Gvdiff HEAD<CR>
  nnoremap <Leader>gs :Gstatus<CR>:20wincmd +<CR>
  nnoremap <Leader>gw :Gwrite<CR>
  nnoremap <Leader>gb :Gblame -w<CR>:vertical resize 10<CR>
  nnoremap <Leader>gci :Gcommit --verbose<CR>
"" }}}

"" Plugin: Vim Signify {{{
  " Indicate added, modified and removed lines based on data of VCS
  Plug 'mhinz/vim-signify'
  " default updatetime 4000ms is not good for async update
  set updatetime=100
  " Key mappings for jumping between changed blocks
  nmap <Leader>gj <plug>(signify-next-hunk)
  nmap <Leader>gk <plug>(signify-prev-hunk)
  nmap <Leader>gJ 9999<Leader>gj
  nmap <Leader>gK 9999<leader>gk
  " Key mappings to diff hunks
  noremap <Leader>ghd :SignifyHunkDiff<CR>
  noremap <Leader>ghu :SignifyHunkUndo<CR>
  " Key mappings for git hunk text objects
  omap ih <plug>(signify-motion-inner-pending)
  xmap ih <plug>(signify-motion-inner-visual)
  omap ah <plug>(signify-motion-outer-pending)
  xmap ah <plug>(signify-motion-outer-visual)
"" }}}

"" Plugin: Gundo {{{
  " Make browsing Vim's powerful undo tree less painful
  Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
  " Map GundoToggle to <F12>
  nnoremap <silent> <F12> :GundoToggle<CR>
  " Set the horizontal width of Gundo graph
  let g:gundo_width=40
  " Force the preview window below current windows
  let g:gundo_preview_bottom=1
  " Set 1 to open the right side instead of the left
  let g:gundo_right=0
  " Disable Gundo entirely if machine not support python
  if v:version < '703' || !has('python')
    let g:gundo_disable=1
  endif
  " Rendering diff automatically with cursor move
  let g:gundo_auto_preview=1
"" }}}
