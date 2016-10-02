""" Start Pathogen
execute pathogen#infect()

""" Enable plugins, disable backwards compatibility
set nocompatible
syntax on
filetype plugin indent on

""" Veloth color theme
:colorscheme veloth
let g:veloth_transparent = 1

""" Some general settings
set number title ruler laststatus=2 modelines=5 hlsearch

""" Tabs
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

""" Backspace
set backspace=indent,eol,start

""" Auto commands
autocmd BufRead, BufNewFile *.coffee sw=2 ts=2

""" Whitespace highlighting
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

""" markdown
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

""" clang
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_complete_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_trailing_placeholder=1
let g:clang_close_preview=1
let g:clang_snippets=1

""" Sessions
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

""" tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(whoami)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a'],
      \'z'    : '#H'}

""" General options

""" Terminal color options
set t_Co=256

""" GUI tweaks: font/transparency
if has("gui_running")
  set guifont="Inconsolata-dz for Powerline:h11"
  set transparency=10
endif

""" load platform configuration
if filereadable("~/.vim_platform")
  :source "~/.vim_platform"
endif
