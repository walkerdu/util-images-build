"==============================vim-plug BEGIN=================================================

"if !filereadable('~/.vim/autoload/plug.vim')
"  silent !curl --insecure -fLo ~/.vim/autoload/plug.vim 
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/0.10.0/plug.vim
"endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'WolfgangMehner/bash-support', { 'commit': '99c746c' }

call plug#end()

"==============================vim-plug END=================================================
"
"
"
"==============================Bash-support-BEGIN=================================================
"===============================================================================
"          File:  customization.vimrc
" 
"   Description:  suggestion for a personal configuration file ~/.vimrc
" 
"   VIM Version:  7.0+
"        Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
"  Organization:  FH Südwestfalen, Iserlohn
"       Version:  1.0
"       Created:  18.05.2013 21:59
"      Revision:  ---
"       License:  Copyright (c) 2013, Dr. Fritz Mehner
"===============================================================================

"
"===============================================================================
" GENERAL SETTINGS
"===============================================================================

"-------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------------
set nocompatible
"
"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
syntax    on            
"
" Platform specific items:
" - central backup directory (has to be created)
" - default dictionary
" Uncomment your choice.  
if  has("win16") || has("win32")     || has("win64") || 
  \ has("win95") || has("win32unix")
    "
"    runtime mswin.vim
"    set backupdir =$VIM\vimfiles\backupdir
"    set dictionary=$VIM\vimfiles\wordlists/german.list
else
"    set backupdir =$HOME/.vim.backupdir
"    set dictionary=$HOME/.vim/wordlists/german.list
endif
"
" Using a backupdir under UNIX/Linux: you may want to include a line similar to
"   find  $HOME/.vim.backupdir -name "*" -type f -mtime +60 -exec rm -f {} \;
" in one of your shell startup files (e.g. $HOME/.profile)
"
"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
set backup                      " keep a backup file
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse=a                     " enable the use of the mouse
set nowrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set shiftwidth=4                " number of spaces to use for each step of indent
set showcmd                     " display incomplete commands
set smartindent                 " smart autoindenting when starting a new line
set tabstop=4                   " number of spaces that a <Tab> counts for
set visualbell                  " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
"
"===================================================================================
" BUFFERS, WINDOWS
"===================================================================================
"
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufNewFile,BufRead * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" close window (conflicts with the KDE setting for calling the process manager)
"-------------------------------------------------------------------------------
 noremap  <C-Esc>       :close<CR>
inoremap  <C-Esc>  <C-C>:close<CR>
"
"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
 noremap  <silent> <s-tab>       :if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap  <silent> <s-tab>  <C-C>:if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q (KDE): Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
nnoremap  <C-q>    :wqall<CR>
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"
"-------------------------------------------------------------------------------
"  some additional hot keys
"-------------------------------------------------------------------------------
"    F2   -  write file without confirmation
"    F3   -  call file explorer Ex
"    F4   -  show tag under curser in the preview window (tagfile must exist!)
"    F5   -  open quickfix error window
"    F6   -  close quickfix error window
"    F7   -  display previous error
"    F8   -  display next error   
"-------------------------------------------------------------------------------
"
noremap   <silent> <F2>        :write<CR>
noremap   <silent> <F3>        :Explore<CR>
nnoremap  <silent> <F4>        :exe ":ptag ".expand("<cword>")<CR>
noremap   <silent> <F5>        :copen<CR>
noremap   <silent> <F6>        :cclose<CR>
noremap   <silent> <F7>        :cp<CR>
noremap   <silent> <F8>        :cn<CR>
"
inoremap  <silent> <F2>   <Esc>:write<CR>
inoremap  <silent> <F3>   <Esc>:Explore<CR>
inoremap  <silent> <F4>   <Esc>:exe ":ptag ".expand("<cword>")<CR>
inoremap  <silent> <F5>   <Esc>:copen<CR>
inoremap  <silent> <F6>   <Esc>:cclose<CR>
inoremap  <silent> <F7>   <Esc>:cp<CR>
inoremap  <silent> <F8>   <Esc>:cn<CR>
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"
vnoremap ( s()<Esc>P
vnoremap [ s[]<Esc>P
vnoremap { s{}<Esc>P
"
"-------------------------------------------------------------------------------
" autocomplete quotes
"-------------------------------------------------------------------------------
vnoremap  '  s''<Esc>P<Right>
vnoremap  "  s""<Esc>P<Right>
vnoremap  `  s``<Esc>P<Right>
"
inoremap	'  '<Esc>:call QuoteInsertionWrapper("'")<CR>a
inoremap	"  "<Esc>:call QuoteInsertionWrapper('"')<CR>a
inoremap	`  `<Esc>:call QuoteInsertionWrapper('`')<CR>a
"
"-------------------------------------------------------------------------------
" function QuoteInsertionWrapper			{{{3
"
" Add a second quote only if the left and the right character are not keyword
" characters and the right character is not the same quote.
"-------------------------------------------------------------------------------
function! QuoteInsertionWrapper (quote)
  let col   = col('.')
  let line  = getline('.')
  if    ( line[col-2] =~ '\k'    )
  \  || ( line[col  ] =~ '\k'    )
  \  || ( line[col-2] =~ a:quote )
  \  || ( line[col  ] =~ a:quote )
    return a:quote
  else
    return a:quote.a:quote."\<Left>"
  endif
endfunction 
"
"===============================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===============================================================================
"
"-------------------------------------------------------------------------------
" plugin bash-support.vim
"-------------------------------------------------------------------------------
" --empty --
"                         
"-------------------------------------------------------------------------------
" taglist.vim : toggle the taglist window
"-------------------------------------------------------------------------------
 noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
"==============================Bash-support-END=================================================


"========================================walkerdu-BEGIN===========================================

"------------------vim-environment----------------
set nu
set nobackup

set wrap

set tabstop=4
set expandtab

set listchars=tab:.-,extends:>
set list

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

filetype indent on
set autoindent shiftwidth=4

"as :tselect, list the matching tags when enter 'ctrl + ]'
nmap <c-]> g<c-]> 

set dir=/tmp/walkerdu_vim
set bsdir=/tmp/walkerdu_vim
set bdir=/tmp/walkerdu_vim 
set wrap!

set colorcolumn=120
set fileformat=unix

"-----------------python header BEGIN---------------------
func HeaderPython()
    call setline(1, "#!env python")
    call setline(2, "#coding=utf8")
    call setline(3, "#===============================================================================")
    call setline(4, "#")
    call setline(5, "#          FILE: " . expand('%:t'))
    call setline(6, "#")
    call setline(7, "#         USAGE: python " . expand('%:t'))
    call setline(8, "#") 
    call setline(9, "#   DESCRIPTION:")
    call setline(10, "#")
    call setline(11, "#       OPTIONS: ")
    call setline(12, "#  REQUIREMENTS: ")
    call setline(13, "#          BUGS: ")
    call setline(14, "#         NOTES: ")
    call setline(15, "#        AUTHOR: walkerdu ")
    call setline(16, "#  ORGANIZATION: ")
    call setline(17, "#       CREATED: " . strftime('%F %T', localtime()))
    call setline(18, "#      REVISION:")
    call setline(19, "#===============================================================================")
    normal G
    normal o
    normal o
endfunc

autocmd bufnewfile *.py call HeaderPython()
"-----------------python header END---------------------

"-----------------c/c++ header BEGIN---------------------
func HeaderCpp()
    call setline(1, "/*")
    call setline(2, " * =====================================================================================")
    call setline(3, " *")
    call setline(4, " *       Filename:  " . expand('%:t'))
    call setline(5, " *")
    call setline(6, " *    Description:")
    call setline(7, " *")
    call setline(8, " *        Version:  1.0")
    call setline(9, " *        Created:  " . strftime('%F %T', localtime()))
    call setline(10, " *       Revision:  none")
    call setline(11, " *       Compiler:  gcc")
    call setline(12, " *         Coding:  utf-8")
    call setline(13, " *")
    call setline(14, " *         Author:  walkerdu")
    call setline(15, " *   Organization:")
    call setline(16, " *")
    call setline(17, " * =====================================================================================")
    call setline(18, " */")

    normal G
    normal o
endfunc

autocmd bufnewfile *.h,*.cpp,*.cc call HeaderCpp()
"-----------------c++ header END---------------------

"-----------------lua header BEGIN---------------------
func HeaderLua()
    call setline(1, "--[[")
    call setline(2, " * =====================================================================================")
    call setline(3, " *")
    call setline(4, " *       Filename:  " . expand('%:t'))
    call setline(5, " *")
    call setline(6, " *    Description:")
    call setline(7, " *")
    call setline(8, " *        Version:  1.0")
    call setline(9, " *        Created:  " . strftime('%F %T', localtime()))
    call setline(10, " *       Revision:  none")
    call setline(11, " *       Compiler:  lua-5.3.4")
    call setline(12, " *         Coding:  utf-8")
    call setline(13, " *")
    call setline(14, " *         Author:  walkerdu")
    call setline(15, " *   Organization:")
    call setline(16, " *")
    call setline(17, " * =====================================================================================")
    call setline(18, "--]] --")

    normal G
    normal o
endfunc

autocmd bufnewfile *.lua call HeaderLua()
"-----------------lua header END---------------------


"========================================walkerdu-END===========================================
set mouse=                     " enable the use of the mouse
