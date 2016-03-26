set nocompatible          " behave like vim not vi                                                                                                                                         
execute pathogen#infect()
 
set t_Co=256              " force 256 color mode
""colorscheme mag256
 
set encoding=utf8         " show utf8 encoding
set fileencoding=utf8     " save files with utf8 encoding
set tabstop=2             " n columns per tab
set shiftwidth=2          " n columns to indent with << and >>
set expandtab             " insert spaces for tabs
set nowrap                " don't wrap long lines
set hidden                " don't force save before opening buffer
set exrc                  " enable per-directory .vimrc files
set laststatus=2          " show status line
set nomodeline            " don't want editor specific commands in files
set number                " show linenumber
set numberwidth=4         " set the number width
 
syntax on
filetype on
filetype indent on
filetype plugin on


"" highlight the cursoer row/col
set cursorcolumn
set cursorline
highlight CursorColumn   ctermfg=none  ctermbg=235   cterm=none
highlight CursorLine     ctermfg=none  ctermbg=235   cterm=none
highlight CursorLineNr   ctermfg=239  ctermbg=235   cterm=none
highlight LineNr         ctermfg=239  ctermbg=none   cterm=none

"" setup hdevtools
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>


let mapleader=","
