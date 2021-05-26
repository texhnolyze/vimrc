" plugins.search.vim

"" Plugin: CtrlP {{{
  " Full path fuzzy file, buffer, mru, tag finder for Vim
  " Plug 'ctrlpvim/ctrlp.vim'
  " Change default mapping
  let g:ctrlp_map='<c-p>'
  " Change default command
  let g:ctrlp_cmd='CtrlP'
  " Enable searching of all files in a big project
  " see https://github.com/kien/ctrlp.vim/issues/234
  let g:ctrlp_max_files=0
  let g:ctrlp_max_depth=60
  " Set custom ignore folder/files for file search
  let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
  \ 'file': '\v\.(exe|so|dll|log)$',
  \ 'link': '',
  \ }
"" }}}

"" Plugin: Fzf {{{
  " Full path fuzzy file, buffer, mru, tag finder for Vim
  " A general-purpose command-line fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  function! s:find_git_root()
    return systemlist('git rev-parse --show-toplevel 2> /dev/null || pwd')[0]
  endfunction

  function! s:git_changed_files()
     return systemlist(
     \ 'git -C ' . s:find_git_root() .
     \ ' ls-files --modified --others --exclude-standard --full-name 2> /dev/null'
     \ )
  endfunction

  " Advanced ripgrep integration retrigger ripgrep on query change
  " see: https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
  function! RgFzf(query, fullscreen)
    let command_fmt='rg --line-number --no-heading --no-ignore-vcs %s || true'
    let initial_command=printf(command_fmt, shellescape(a:query))
    let reload_command=printf(command_fmt, '{q}')

    let options={
    \ 'options': [
    \   '--phony',
    \   '--query',
    \   a:query,
    \   '--bind',
    \   'change:reload:' . reload_command,
    \ ]
    \}
    if a:fullscreen
      let options=fzf#vim#with_preview(options)
    endif

    call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
  endfunction

  " Search through current git repo not current folder
  function! GitFilesRg(query, fullscreen)
    let command='rg --line-number --no-heading -- ' . a:query

    let options={
    \ 'dir': s:find_git_root(),
    \ 'options': [
    \   '--prompt=ProjectFilesRg> ',
    \   '--delimiter=:',
    \   '--nth=3..',
    \   '--color=hl:108,hl+:108',
    \ ],
    \}

    if a:fullscreen
      let options=fzf#vim#with_preview(options)
    endif

    call fzf#vim#grep(command, 1, options, a:fullscreen)
  endfunction

  command! -bang ProjectFiles
    \ call fzf#vim#files(
    \   s:find_git_root(),
    \   fzf#vim#with_preview({
    \     'options': [
    \       '--prompt=ProjectFiles> ',
    \       '--delimiter=/',
    \       '--with-nth=-3..',
    \     ],
    \   }),
    \   <bang>0)

  command! -nargs=* -bang RG call RgFzf(<q-args>, <bang>0)

  command! -nargs=* -bang ProjectFilesRg
    \ call GitFilesRg(shellescape(<q-args>), <bang>0)

  command! -nargs=* -bang ChangedProjectFilesRg
    \ call GitFilesRg(
    \   shellescape(<q-args>) . ' ' . join(s:git_changed_files()),
    \   <bang>0)

  " Mappings for searches of files, content and commits
  nnoremap <silent> <C-p> :<C-u>ProjectFiles!<CR>
  nnoremap <silent> <Leader>gf :<C-u>GFiles!?<CR>
  nnoremap <silent> <C-f> :<C-u>RG!<CR>
  nnoremap <silent> <C-g> :<C-u>ProjectFilesRg!<CR>
  nnoremap <silent> <Leader>gg :<C-u>ChangedProjectFilesRg!<CR>
  nnoremap <silent> <C-c> :<C-u>Commits!<CR>
  nnoremap <silent> <Leader>gl :<C-u>BCommits!<CR>
"" }}}

"" Plugin: Ferret {{{
  " Provides multi file search/replace with rg, ag or ack
  Plug 'wincent/ferret'
  " Remap ferret search/replace keybindings
  nmap <Leader>s <Plug>(FerretAck)
  nmap <Leader>sw <Plug>(FerretAckWord)
  nmap <Leader>r <Plug>(FerretAcks)
"" }}}

"" Plugin: Easymotion {{{
  " Provides a much simpler way to use motions in Vim
  Plug 'Lokaltog/vim-easymotion'
  " Set easymotion line and sneak keybindings
  nmap s <Plug>(easymotion-overwin-f)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  map <Leader>l <Plug>(easymotion-lineforward)
  map <Leader>h <Plug>(easymotion-linebackward)
"" }}}

"" Plugin: Vim Signature {{{
  " To place, toggle, display and navigate marks
  " Keymap:
  " mx        Toggle mark 'x' where x is a-zA-Z
  " dmx       Remove mark 'x' where x is a-zA-Z
  " m,        Place the next available mark
  " m.        If no mark on line, place the next available mark
  " m-        Delete all marks from the current line
  " m/        Open location list and display marks
  " m<Space>  Delete all marks from the current buffer
  " m[0-9]    Toggle the corresponding marker !@#$%^&*()
  " m<S-[0-9]>Remove all markers of the same type
  " m?        Open location list and display markers
  " m<BS>     Remove all markers
  " ]`        Jump to next mark
  " [`        Jump to prev mark
  " ]'        Jump to start of next line containg a mark
  " ['        Jump to start of prev line containg a mark
  Plug 'kshenoy/vim-signature'
  " Highlight signs of marks dynamically based upon state
  " indicated by vim-signify
  let g:SignatureMarkTextHLDynamic=1
"" }}}

"" Plugin: TaskList {{{
  " Eclipse like task list
  Plug 'vim-scripts/TaskList.vim'
  " Map TaskList to <Leader>tt
  nnoremap <silent> <Leader>tt :TaskList<CR>
"" }}}

"" Plugin: Tagbar {{{
  " Easy way to browse the tags
  Plug 'majutsushi/tagbar'
  " Map TagbarToggle to <F10>
  nnoremap <silent> <F10> :TagbarToggle<CR>
"" }}}

"" Plugin: NERDTree {{{
  " Explore filesystem with Vim
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeTabsToggle'] }
  " Ignore some extensions
  let NERDTreeIgnore=['.o$','.pyc$']
  " Show hidden files
  let NERDTreeShowHidden=1
  " Automatically open NERDTree when vim start up with no files
  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
  " Close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree')
  \ && b:NERDTree.isTabTree()) | q | endif
  " Map NERDTreeToggle to <Leader>n
  nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
"" }}}

"" Plugin: NERDTree Git Plugin {{{
  " A plugin of NERDTree showing git status flags
  Plug 'Xuyuanp/nerdtree-git-plugin'
  " Use this variable to change symbols
  let g:NERDTreeIndicatorMapCustom={
  \ 'Modified'  : '*',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Deleted'   : '✖',
  \ 'Dirty'     : '✗',
  \ 'Clean'     : '✔︎',
  \ 'Unknown'   : '?'
  \ }
"" }}}

"" Plugin: NERDTree Tabs {{{
  " NERDTree and tabs together in Vim
  Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
  " Map NERDTreeToggle to <F11>
  nnoremap <silent> <F11> :NERDTreeTabsToggle<CR>
"" }}}
