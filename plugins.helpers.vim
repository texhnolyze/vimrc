" plugins.helpers.vim

"" Plugin: WebAPI Vim {{{
  " Provide interface for Web API
  " Dependency for Emmet-Vim Custom Snippet
  Plug 'mattn/webapi-vim'
"" }}}

"" Plugin: Eunuch.vim {{{
  " Provides vim commands for common UNIX shell commands
  Plug 'tpope/vim-eunuch'
"" }}}

"" Plugin: Vim QF {{{
  " Small collection of settings, commands and mappings put together to make
  " working with the location/quickfix list/window smoother
  Plug 'romainl/vim-qf'
  " Enable Ack style mapping only in location/quickfix windows
  " s - open entry in a new horizontal window
  " v - open entry in a new vertical window
  " t - open entry in a new tab
  " o - open entry and come back
  " O - open entry and close the location/quickfix window
  " p - open entry in a preview window
  let g:qf_mapping_ack_style=1
  " Open the quickfix window at the bottom of the screen
  let g:qf_window_bottom=0
  " Open the location window at the bottom of the screen
  let g:qf_loclist_window_bottom=0
  " Open the quickfix window automatically if there are any errors
  let g:qf_auto_open_quickfix=1
  " Open the location window automatically if there are any locations
  let g:qf_auto_open_loclist=1
"" }}}

"" Plugin: Vim Slash {{{
  " Provides a set of mappings for enhancing in-buffer search experience
  " Automatically clears search highlight when cursor is moved
  " Improved start-search (visual-mode, highlighting without moving)
  Plug 'junegunn/vim-slash'
"" }}}

"" Plugin: Vim Smoothie {{{
  " Make scrolling nice and smooth
  Plug 'psliwka/vim-smoothie'
"" }}}

"" Plugin: Repeat.vim {{{
  " Enable repeating supported plugin maps with `.`
  Plug 'tpope/vim-repeat'
"" }}}

"" Plugin: Vim Obsession {{{
  " Enable saving vim sessions to be
  " resurrected with tmux-resurrect
  Plug 'tpope/vim-obsession'
"" }}}
"
"" Plugin: Vim Autosave {{{
  " Enable autosaving on changes of buffer on changes
  " in normal mode and on return from insert mode
  " Plug '907th/vim-auto-save'
  " Enable on startup
  let g:auto_save=1
"" }}}
