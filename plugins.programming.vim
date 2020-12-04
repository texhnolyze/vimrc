" plugins.programming.vim

"" Plugin: Vim Polyglot {{{
  " A collection of language packs for Vim
  Plug 'sheerun/vim-polyglot'
  " No conceal in JSON
  let g:vim_json_syntax_conceal=0
  " Enable syntax highlighting for JSDocs
  let g:javascript_plugin_jsdoc=1
  " Autoformat rust code on save
  let g:rustfmt_autosave=1
"" }}}

"" Plugin: ALE {{{
  " Asynchronous Lint Engine
  " Plug 'w0rp/ale'
  " Enable ALE
  let g:ale_enable=1
  " Set the language specific linters
  let g:ale_linters={
  \ 'javascript': ['eslint'],
  \ 'python': ['flake8'],
  \ 'terraform': ['tflint'],
  \ 'sh': ['language_server'],
  \ }
  " Set aliases from one filetype to another
  let g:ale_linter_aliases={
  \ 'javascript': ['javascript', 'javascript.jsx', 'jsx', 'vue'],
  \ }
  " No lint everytime for my battery
  let g:ale_lint_on_text_changed='normal'
  " Run after the delay
  let g:ale_lint_delay=400
  " Run on opening a file
  let g:ale_lint_on_enter=1
  " Run on saving a file
  let g:ale_lint_on_save=1
  " Run on leaving insert mode
  let g:ale_lint_on_insert_leave=1
  " Set the language specific fixers
  let g:ale_fixers={
  \ 'javascript': ['eslint']
  \ }
  " Fix linting errors on save
  let g:ale_fix_on_save=1
  " Don't open loclist if false
  let g:ale_open_list=1
  " Set the number of error lines
  let g:ale_list_window_size=3
  " Customize the output format of statusline
  let g:ale_statusline_format=['⨉ %d', '⚠ %d', '⬥ ok']
  " Customize the echo message
  let g:ale_echo_msg_error_str='E'
  let g:ale_echo_msg_warning_str='W'
  let g:ale_echo_msg_format='[%severity%:%linter%] %s'
"" }}}

"" Plugin: NeoMake {{{
  " Async :make and linting framework for Vim/NeoVim
  " Plug 'neomake/neomake', { 'for': [
  " \ 'c', 'cpp', 'java', 'python', 'javascript', 'scala', 'sh', 'vim'
  " \ ] }
  " Open the location-list or quickfix list with preserving the cursor
  let g:neomake_open_list=2
  " Set the height of hte location-list or quickfix list
  let g:neomake_list_height=6
  " Echo the error for the current line
  let g:neomake_echo_current_error=1
  " Place signs by errors recognized
  let g:neomake_place_signs=1
  " Set the appearance of the signs
  let g:neomake_error_sign={'text': '✖', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningSign'}
  let g:neomake_message_sign={'text': '➤', 'texthl': 'NeomakeMessageSign'}
  let g:neomake_info_sign={'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
  " Highlight the columns of errors recognized
  let g:neomake_highlight_columns=1
  " Highlight the lines of errors recognized
  let g:neomake_highlight_lines=0
  " Change highlight color for the columns recognized
  augroup neomake_highlights_hook
    autocmd!
    autocmd ColorScheme * highlight NeomakeError
      \ term=bold cterm=bold guibg=red ctermbg=red
    autocmd ColorScheme * highlight NeomakeErrorSign
      \ term=bold cterm=bold guifg=red ctermfg=red
  augroup END
  " Run Neomake at save and when reading a file
  function! NeomakeHook()
    if exists(':Neomake')
      augroup neomake_hook
        autocmd!
        autocmd BufWritePost * Neomake
      augroup END
    endif
  endfunction
  autocmd VimEnter * call NeomakeHook()
  " Set makers for each filetype
  let g:neomake_c_enabled_makers=['clang']
  let g:neomake_c_clang_args=['-std=c11', '-Wall', '-Wextra', '-fsyntax-only']
  let g:neomake_cpp_enable_makers=['clang']
  let g:neomake_cpp_clang_args=[
  \ '-std=c++14', '-Wall', '-Wextra', '-fsyntax-only'
  \ ]
  let g:neomake_java_enabled_makers=['javac']
  let g:neomake_python_enabled_makers=['flake8']
  let g:neomake_javascript_enabled_makers=['eslint']
  let s:eslint_path=system('PATH=$(npm bin):$PATH && which eslint')
  let b:neomake_javascript_eslint_exe=substitute(
  \ s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', ''
  \ )
  let g:neomake_scala_enabled_makers=['scalac']
  let g:neomake_sh_enabled_makers=['shellcheck']
  let g:neomake_vim_enabled_makers=['vint']
"" }}}

"" Plugin: Syntastic {{{
  " Syntax checking for Vim with external syntax checker
  " TODO: Too slow because of synchronous job
  " Plug 'scrooloose/syntastic'
  " set statusline+=%#warningmsg#
  " set statusline+=%{SyntasticStatuslineFlag()}
  " set statusline+=%*
  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_loc_list_height=5
  let g:syntastic_auto_loc_list=1
  let g:syntastic_check_on_open=1
  let g:syntastic_check_on_wq=0
  " Symbols
  let g:syntastic_error_symbol='✘'
  let g:syntastic_warning_symbol='▲'
  " For C / C++
  let g:syntastic_cpp_compiler='clang++'
  let g:syntastic_cpp_compiler_options=' -std=c++11'
  " For Python
  let g:syntastic_python_checkers=['flake8']
  " For Scala & Java
  " let g:syntastic_scala_checkers=['fsc', 'scalac']
  " For Javascript & Node.JS
  let g:syntastic_javascript_checkers=['eslint']
  let s:eslint_path=system('PATH=$(npm bin):$PATH && which eslint')
  let b:syntastic_javascript_eslint_exec=substitute(s:eslint_path,
  \ '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  " For Shell Script(sh, bash)
  let g:syntastic_sh_checkers=['shellcheck']
"" }}}

"" Plugin: Vim Dispatch {{{
  " Asynchronous build and test dispatcher
  Plug 'tpope/vim-dispatch'
"" }}}

" Plugin: Vim Tmux Runner {{{
  " Send commands to tmux
  " Used to run vim-test in a small tmux pane
  Plug 'christoomey/vim-tmux-runner'
"" }}}"

"" Plugin: Vim Test {{{
  " Run your tests at the speed of thought
  Plug 'janko/vim-test'
  " Make test commands execute using other strategy
  let test#strategy='basic'
  " set custom jest executable to support vue using babel
  " let test#javascript#jest#executable = 'npm run --silent test --'
  " Exit after testing with jest
  let test#javascript#jest#options='--passWithNoTests'
  nnoremap <silent> <Leader>tf :TestFile<CR>
  nnoremap <silent> <Leader>tn :TestNearest<CR>
  nnoremap <silent> <Leader>ts :TestSuit<CR>
  nnoremap <silent> <Leader>tl :TestLast<CR>
  nnoremap <silent> <Leader>tv :TestVisit<CR>
"" }}}

"" Plugin: EchoDoc {{{
  " Displays function signatures from completions in the command line
  Plug 'Shougo/echodoc.vim'
"" }}}

"" Plugin: Deoplete(NeoVIM only) {{{
  " Dark powered asynchronous completion framework
  " if has('nvim')
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " else
    " Plug 'Shougo/deoplete.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
  " endif
  " " Javascript source for Deoplete
  " Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript'], 'do': 'npm install -g tern' }
  " " Add extra filetypes
  " let g:tern#filetypes=['jsx', 'javascript.jsx', 'vue']
  " " Use tern_for_vim
  " let g:tern#command=['tern']
  " let g:tern#arguments=['--persistent']
  " " Include documentation strings (if found) in the result data
  " let g:deoplete#sources#ternjs#docs=1
  " " Use a case-insensitive compare
  " let g:deoplete#sources#ternjs#case_insensitive=1
  " " Sort the result set
  " let g:deoplete#sources#ternjs#sort=1
  " " Ignore JavaScript keywords when completing
  " let g:deoplete#sources#ternjs#include_keywords=0

  " " Python source for Deoplete
  " Plug 'zchee/deoplete-jedi', { 'for': ['python'] }
  " " Enable caching of completions for faster results
  " let g:deoplete#sources#jedi#enable_cache=1
  " " Show docstring in preview window
  " let g:deoplete#sources#jedi#show_docstring=0

  " if executable('gocode')
    " " Go source for Deoplete
    " Plug 'zchee/deoplete-go', { 'do': 'make', 'for': ['go'] }
    " " By default(not set), Find the gocode binary in $PATH environment
    " let g:deoplete#sources#go#gocode_binary=$GOPATH.'/bin/gocode'
    " " By default, the completion word list is in the sort order of gocode
    " " Available values are [package, func, type, var, const]
    " let g:deoplete#sources#go#sort_class=['package', 'func', 'type', 'var', 'const']
    " " Use static json caching Go stdlib package API
    " let g:deoplete#sources#go#use_cache=1
    " let g:deoplete#sources#go#json_directory='~/.cache/deoplete/go/$GOOS_$GOARCH'
  " endif

  " " Vim source for Neocomplete/Deoplete
  " Plug 'Shougo/neco-vim', { 'for': ['vim'] }
  " " Insert mode completion of words in adjacent tmux panes
  " Plug 'wellle/tmux-complete.vim'

  " " Run deoplete automatically
  " let g:deoplete#enable_at_startup=1
  " " When a capital letter is included in input, does not ignore
  " let g:deoplete#enable_smart_case=1
  " " Set the number of the input completion at the time of key input
  " let g:deoplete#auto_complete_start_length=2
  " " Set the limit of candidates
  " let g:deoplete#max_list=32
  " " Close the preview window after completion is done
  " autocmd CompleteDone * pclose!
  " " Disable the preview window
  " set completeopt-=preview

  " " Enable tabbing through autocomplete suggestions
  " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"" }}}

"" Plugin: Language Servers {{{
  " Language server for JavaScript and TypeScript
  " Plug 'theia-ide/typescript-language-server', { 'do': 'yarn && yarn build' }
"" }}}

"" Plugin: CoC (Conquer of Completion) {{{
  " Intellisense engine, full language server protocol support as VSCode
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Use tab for trigger completion and navigation
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <C-Space> to trigger completion
  inoremap <silent><expr> <C-Space> coc#refresh()

  " Use <CR> to confirm completion including snippets
  "<C-g>u breaks the undo chain at current position
  if exists('*complete_info')
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use <Leader>dk and <Leader>dj to navigate diagnostics
  nmap <silent> <Leader>dk <Plug>(coc-diagnostic-prev)
  nmap <silent> <Leader>dj <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <Leader>rn <Plug>(coc-rename)

  " Formatting selected code
  xmap <Leader>f <Plug>(coc-format-selected)
  nmap <Leader>f <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Apply codeAction to the selected region
  " Example: `<Leader>aap` for current paragraph
  xmap <Leader>a <Plug>(coc-codeaction-selected)
  nmap <Leader>a <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer
  nmap <Leader>ac <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line
  nmap <Leader>qf <Plug>(coc-fix-current)
  nmap <A-CR> <Plug>(coc-fix-current)

  " Map function and class text objects
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use <C-s> for selections ranges
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add :Format command to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Add :Imports command for organize imports of the current buffer
  command! -nargs=0 Imports :call CocAction('runCommand', 'editor.action.organizeImport')

  " Mappings for CoCList
  " Show all diagnostics
  nnoremap <silent><nowait> <Space>a :<C-u>CocList diagnostics<CR>
  " Show commands
  nnoremap <silent><nowait> <Space>c :<C-u>CocList commands<CR>
  " Find symbol of current document
  nnoremap <silent><nowait> <Space>o :<C-u>CocList outline<CR>
  " Search workspace symbols
  nnoremap <silent><nowait> <Space>s :<C-u>CocList -I symbols<CR>
"" }}}

"" Plugin: LanguageClient(NeoVIM only) {{{
  " Support Language Server Protocol for NeoVIM
  " if has('nvim')
    " Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    " " Automatically start language servers
    " let g:LanguageClient_autoStart=1
    " " Define commands to execute to start language servers
    " let g:LanguageClient_serverCommands={
    " \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    " \ 'go': ['go-langserver'],
    " \ 'typescript': ['node', '$VIM_HOME/plugged/typescript-language-server/lib/cli.js', '--stdio'],
    " \ 'typescript.tsx': ['node', '$VIM_HOME/plugged/typescript-language-server/lib/cli.js', '--stdio'],
    " \ 'tsx': ['node', '$VIM_HOME/plugged/typescript-language-server/lib/cli.js', '--stdio'],
    " \ 'javascript': ['node', '$VIM_HOME/plugged/typescript-language-server/lib/cli.js', '--stdio'],
    " \ 'javascript.jsx': ['node', '$VIM_HOME/plugged/typescript-language-server/lib/cli.js', '--stdio'],
    " \ 'jsx': ['node', '$VIM_HOME/plugged/typescript-language-server/lib/cli.js', '--stdio'],
    " \ 'sh': ['bash-language-server', 'start'],
    " \ }
    " " \ 'python': ['pyls'],

    " " Disable diagnostics integration
    " let g:LanguageClient_diagnosticsEnable=0
    " " Set selection UI used when there are multiple entries
    " let g:LanguageClient_selectionUI='fzf'

    " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    " nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
    " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
    " nnoremap <silent> <F5> :call LanguageClient_textDocument_codeAction()<CR>
    " nnoremap <silent> <F6> :call LanguageClient_textDocument_references()<CR>
    " nnoremap <silent> <Alt+l> :call LanguageClient_textDocument_formatting()<CR>
  " endif
"" }}}

"" Plugin: UltiSnips {{{
  " Snippet engine for Vim
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  " Explicitly set Python version to use
  if has('python3')
    let g:UltiSnipsUsePythonVersion=3
  else
    let g:UltiSnipsUsePythonVersion=2
  endif
  " Configure keys trigerring UltiSnips
  let g:UltiSnipsJumpForwardTrigger='<C-l>'
  let g:UltiSnipsJumpBackwardTrigger='<C-h>'
  let g:UltiSnipsListSnippets='<Tab>l'
  " Enable of usage of CR for both newlines and snippet completion
  let g:UltiSnipsExpandTrigger='<NOP>'
  let g:ulti_expand_res=0
  inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrReturnEmptyString()<CR>
  function! s:ExpandSnippetOrReturnEmptyString()
    if pumvisible()
      let snippet=UltiSnips#ExpandSnippet()
      if g:ulti_expand_res > 0
          return snippet
      else
          return "\<C-y>\<CR>"
      endif
    else
        return "\<CR>"
    endif
  endfunction

  " If you want :UltiSnipsEdit to split your window
  let g:UltiSnipsEditSplit='vertical'
  "Set save and search dirs for private snippets
  let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snippet-definitions']
"" }}}

"" Plugin: Endwise {{{
" Wisely add `end` in ruby, vim, etc
  Plug 'tpope/vim-endwise', { 'for': [
  \ 'ruby', 'vim', 'sh', 'zsh', 'matlab', 'snippets'
  \ ] }
"" }}}

"" Plugin: NERD Commenter {{{
  " For intensely orgasmic commenting
  Plug 'preservim/nerdcommenter'
  " Comment the whole lines in visual mode
  let g:NERDCommentWholeLinesInVMode=1
  " Add space after the left delimiter and before the right delimiter
  let g:NERDSpaceDelims=1
  " Remove spaces around comment delimiters
  let g:NERDRemoveExtraSpaces=1
"" }}}

"" Plugin: Codi {{{
  " The interactive scratchpad for hackers
  Plug 'metakirby5/codi.vim'
  " Set shortcut to toggle Codi
  nnoremap <Leader><Leader>c :Codi!!<CR>
  xnoremap <Leader><Leader>c :Codi!!<CR>
"" }}}

" Javascript & Node
"" Plugin: Tern for Vim {{{
  " TODO: Key mapping
  " Tern-based Javascript editing support
  " Hook into omni completion to handle autocompletion and provide more
  " function! BuildTern(info)
    " " info is a dictionary with 3 fields
    " " - name:   name of the plugin
    " " - status: 'installed', 'updated', or 'unchanged'
    " " - force:  set on PlugInstall! or PlugUpdate!
    " if a:info.status == 'installed' || a:info.force
      " !npm install
    " endif
  " endfunction
  " Plug 'marijnh/tern_for_vim', { 'for': ['javascript'], 'do': function('BuildTern') }
  " " Set timeout
  " let g:tern_request_timeout=1
  " " Display argument type hints when the cursor is left over a function
  " let g:tern_show_argument_hints='on_hold'
  " " Display function signature in the completion menu
  " let g:tern_show_signature_in_pum='0'
  " " Disable Shortcuts
  " let g:tern_map_keys=0
"" }}}

"" Plugin: Vim Node {{{
  " Tools and environment to make Vim superb for developing with Node.js
  Plug 'moll/vim-node'
"" }}}

"" Plugin: Javascript Libraries Syntax {{{
  " Syntax file for JavaScript libraries
  " Plug 'othree/javascript-libraries-syntax.vim'
  " Set up used libraries
  let g:used_javascript_libs='vue,react,jquery,underscore,handlebars'
"" }}}

" HTML & CSS
"" Plugin: Emmet {{{
  " Provide Zen-coding for Vim
  Plug 'mattn/emmet-vim', {
  \ 'for': [
  \   'html', 'haml', 'jinja', 'hbs', 'html.handlebars', 'xml',
  \   'css', 'less', 'sass', 'javascript', 'typescript'
  \ ]
  \}
  " Enable all functions, which is equal to
  " n: normal, i: insert: v: visual, a: all
  let g:user_emmet_mode='a'
  " Remap the default Emmet leader key <C-Y>
  let g:user_emmet_leader_key='<C-Y>'
  " Customize the behavior of the languages
  let g:user_emmet_settings={
  \ 'javascript.jsx': {
  \   'extends': 'jsx',
  \ },
  \ 'javascript': {
  \   'extends': 'jsx',
  \ },
  \ 'typescript.tsx': {
  \   'extends': 'tsx',
  \ },
  \ 'typescript': {
  \   'extends': 'tsx',
  \ },
  \ 'xml': {
  \   'extends': 'html',
  \ },
  \ 'haml': {
  \   'extends': 'html',
  \ },
  \ 'jinja': {
  \   'extends': 'html',
  \ },
  \ 'hbs': {
  \   'extends': 'html',
  \ },
  \ 'html.handlebars': {
  \   'extends': 'html',
  \ },
  \}
"" }}}

" Saltstack
"" Plugin: Salt Vim {{{
  " Syntax highlighting for salt state files
  Plug 'saltstack/salt-vim', { 'for': ['sls'] }
"" }}}

" Markdown
"" Plugin: Goyo {{{
  " Distraction-free writing
  Plug 'junegunn/goyo.vim'
  " Integrate with other plugins
  function! s:goyo_enter()
    silent !tmux set status off
    set colorcolumn=
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
    LocalIndentGuide -hl -cc
  endfunction

  function! s:goyo_leave()
    silent !tmux set status on
    set colorcolumn=80
    set showmode
    set showcmd
    set scrolloff=3
    Limelight!
    LocalIndentGuide +hl +cc
  endfunction
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
"" }}}

"" Plugin: Limelight {{{
  " Hyperfocus-writing in Vim
  Plug 'junegunn/limelight.vim'
  " Set coefficient value
  let g:limelight_default_coefficient=0.7
  " Configure the number of preceding/following paragraphs to include
  let g:limelight_paragraph_span=1
  " Set shortcut to toggle limelight
  nnoremap <Leader><Leader>l :Limelight!!<CR>
  xnoremap <Leader><Leader>l :Limelight!!<CR>
"" }}}

"" Plugin: Vim Instant Markdown {{{
  " Instant markdown Previews from Vim
  Plug 'suan/vim-instant-markdown', {'for': 'markdown', 'do': 'npm install -g instant-markdown-d'}
  " Only refresh on specific events
  let g:instant_markdown_slow=1
  " Manually control to launch the preview window
  " Command(:InstantMarkdownPreview)
  let g:instant_markdown_autostart=0
  " Allow external content like images
  let g:instant_markdown_allow_external_content=1
"" }}}
