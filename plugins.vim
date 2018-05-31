" plugins.vim

call plug#begin('$VIM_HOME/plugged')

" Define plugins to load into Vim
let plugins_enabled=[
\ 'helpers', 'appearance', 'vcs', 'search', 'editor',
\ 'programming', 'integration', 'themes'
\ ]
for plugin in plugins_enabled
  let plugin_path = $VIM_HOME . '/plugins.' . plugin . '.vim'
  if filereadable(plugin_path)
    execute 'source ' . plugin_path
  endif
endfor

call plug#end()
