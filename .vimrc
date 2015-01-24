""" Start Pathogen
execute pathogen#infect()

""" Enable plugins, disable backwards compatibility
set nocompatible
syntax on
filetype plugin indent on

""" Aldmeris color theme
:colorscheme aldmeris
let g:aldmeris_transparent = 1

""" Modelines
:set modelines=5

""" Tabs
:set tabstop=2
:set shiftwidth=2
:set expandtab

""" Auto commands
autocmd BufRead, BufNewFile *.coffee sw=2 ts=2

""" Whitespace highlighting
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

""" clang
let g:clang_library_path="/Library/Developer/CommandLineTools/usr/lib"
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_complete_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_trailing_placeholder=1
let g:clang_close_preview=1
let g:clang_snippets=1

""" Show line numbers
:set number

""" Terminal color options
set t_Co=256

""" GUI tweaks: font/transparency
if has("gui_running")
  :set guifont="Inconsolata-dz for Powerline:h11"
  :set transparency=10
endif

