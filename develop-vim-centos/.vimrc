"==============================vim-plug BEGIN=================================================

"if !filereadable('~/.vim/autoload/plug.vim')
"  silent !curl --insecure -fLo ~/.vim/autoload/plug.vim 
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/0.10.0/plug.vim
"endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'vim-scripts/taglist.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/bash-support.vim'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/a.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Valloric/YouCompleteMe', { 'commit': '6b6354f', 'do': 'python3 install.py --force-sudo --system-libclang --clang-completer --clangd-completer --go-completer --ts-completer' }
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'andrejlevkovitch/vim-lua-format', { 'commit': '9996af0' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rhysd/vim-clang-format'

call plug#end()

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system

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


"========================================LeaderF BEGIN===========================================
nnoremap <script> <silent> <unique> <Leader>lff :LeaderfFile<CR>
nnoremap <script> <silent> <unique> <Leader>lfu :LeaderfFunction<CR>
nnoremap <script> <silent> <unique> <Leader>lfg :Leaderf rg ...<CR>


" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
"let g:Lf_WindowPosition = 'popup'
"let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>


let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
"let g:Lf_UseVersionControlTool = 0
"let g:Lf_WildIgnore={'file':['*.pb.go', '*.vcxproj'],'dir':[]}
"========================================LeaderF END===========================================

"========================================YouCompleteMe BEGIN===========================================
"let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_server_log_level = 'info'
"let g:ycm_min_num_identifier_candidate_chars = 2
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_complete_in_strings=1
"let g:ycm_key_invoke_completion = '<c-z>'
"set completeopt=menu,menuone
"
"noremap <c-z> <NOP>
"
"let g:ycm_semantic_triggers =  {
"            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"            \ 'cs,lua,javascript': ['re!\w{2}'],
"            \ }
"========================================YouCompleteMe END===========================================


"========================================Gutentags BEGIN===========================================
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"========================================Gutentags END===========================================
"
"========================================fugitive BEGIN===========================================
nnoremap <script> <silent> <unique> <Leader>gitb :Git blame<CR>
"========================================fugitive END===========================================

"========================================nerdtree BEGIN===========================================
nnoremap <script> <silent> <unique> <Leader>NE :NERDTree%<CR>
"========================================nerdtree END===========================================

"========================================vim-clang-format BEGIN===========================================
"退出插入模式时自动格式化
"let g:clang_format#auto_format_on_insert_leave=1
let g:clang_format#detect_style_file=1
"========================================vim-clang-format END===========================================
"
"========================================vim-go BEGIN===========================================
let g:go_imports_autosave = 0
"========================================vim-go END===========================================

"========================================vim-lua-format BEGIN=========================================
"下面两条是自动在打开lua和保存lua文件的时候进行格式化，这里注释掉
"autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
"autocmd BufWrite *.lua call LuaFormat()
"
"快捷键方式<ctrl+c ctrl+k>
nnoremap <buffer> <c-k> :call LuaFormat()<cr>
"命令模式下直接输入LuaFormat进行格式化，借鉴ClangForamt
:command LuaFormat call LuaFormat()
"========================================vim-lua-format END===========================================

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

"------------------plugin-in------------------
let Tlist_Use_Right_Window = 1

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
