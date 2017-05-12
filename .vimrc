"Fish shell doesn't work with syntastic
set shell=bash

"Key Mappings
let g:ctrlp_map = '<c-p>'
map <C-n> :NERDTreeToggle<CR>
map <C-o> :QFix<CR>

"Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Plugins
Plugin 'gmarik/Vundle.vim'               "PluginInstall
Plugin 'ervandew/supertab'               "tab autocomplete!
Plugin 'tpope/vim-surround'              "surround things!
Plugin 'tpope/vim-repeat'                "so . will work w plugins!
Plugin 'tpope/vim-unimpaired'            "key bindings I'll learn one day
Plugin 'scrooloose/nerdtree'             "file navigation
Plugin 'Xuyuanp/nerdtree-git-plugin'     "git status flags
Plugin 'ctrlpvim/ctrlp.vim'              "fuzzy file finder
Plugin 'chriskempson/base16-vim'         "base16 colorschemes
Plugin 'MartinLafreniere/vim-PairTools'
Plugin 'editorconfig/editorconfig-vim'   "editor config
Plugin 'tpope/vim-sensible'              "use whatever tab style is in the file :)
Plugin 'scrooloose/syntastic'            "linters: SyntasticInfo, SyntasticCheck
Plugin 'leafgarland/typescript-vim'
"Plugin 'jiangmiao/auto-pairs'
"Plugin 'Chiel92/vim-autoformat'          "Autoformat
"Plugin 'dbarsam/vim-rainbow-parentheses' "color matching parentheses!

"Language Specific
Plugin 'elzr/vim-json'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'mirlord/vim-dust'
Plugin 'wavded/vim-stylus'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'Vimjas/vim-python-pep8-indent'
"Plugin 'mattn/emmet-vim'                 "awesome html stuff
call vundle#end()

" Syntastic Settings
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['jscs', 'jshint']
"let g:syntastic_javascript_checkers = ['eslint']

" mxw/vim-jsx
let g:jsx_ext_required=0 "JSX highlighting in .js files

" pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1 "JSDoc syntax highlighting

" heavenshell/vim-jsdoc
let g:jsdoc_allow_input_prompt = 1 

" Setting Stuff
set nocompatible
filetype plugin indent on
syntax on         "syntax highlighting

" Indentation
set autoindent    "copies indentation from previous line
set tabstop=2     "how many spaces a tab will look
set shiftwidth=2
set softtabstop=2

set backspace=indent,eol,start
set showmatch     "show matching brackets

set number        "Display line numbers
set numberwidth=5 "We are good up to 99999 lines
set sidescrolloff=10 "Keep 5 lines at the size
set linespace=0  "don't insert any extra pixel lines betweens rows
set scrolloff=5  "Keep 10 lines (top/bottom) for scope

set showcmd       "show the command being typed
set ruler         "Always show current positions along the bottom
set report=0      "tell us when anything is changed via :...
set laststatus=2 "always show the status line
set lazyredraw   "do not redraw while running macros
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Access colors present in 256 colorspace
" base16-vim colorschemes
" Clone this too into ~/.config/
" git@github.com:chriskempson/base16-shell.git
" https://github.com/coderonline/base16-shell/blob/2efe3d201c79f0055d4c47dcf00ccbf2cc094ad8/profile_helper.fish
let base16colorspace=256
colorscheme base16-tomorrow-night 

" extra files that are created go in these folders.
" these folders have to be created before this will work!
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" ----Functions----

" Toggle Quick Fix List
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

" Toggle Quick Fix List
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" Toggle Quick Command 
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

"----Graveyard----
"map <C-t>n :tabnew<CR>
"map <C-t>t :tabnext<CR>
"set incsearch "move while searching
"set cindent       "replaces smartindent
"set expandtab "indentation without tabs
"set list         "show tabs and stuff
"set listchars=trail:. "show trailing
"set novisualbell  "don't blink
"individual format settings
"au BufNewFile,BufRead *.txt set nu!
"au BufNewFile,BufRead *.rtf set nu!
"vim git-gutter
"execute pathogen#infect()
"set matchtime=5   "how many tenths of a second to blink matching brackets for
"autocmd Filetype python setlocal expandtab tabstop=2 shiftwidth=2 " Use spaces in python files

