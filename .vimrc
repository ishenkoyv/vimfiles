set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

set encoding=utf-8
set fileencoding=utf-8

set autoindent 
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround                  "sr:    rounds indent to a multiple of shiftwidth
"set smarttab
"set et
"set wrapmargin=89

set ai
set ci

set nobackup                    "bk:    does not write a persistent backup file of an edited file
set writebackup                 "wb:    does keep a backup file while editing a file

" Allow undoing insert-mode ctrl-u and ctrl-w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Shortcut to add new blank line without entering insert mode
noremap ,<CR> :put_<CR>
"Ctags background scan
nmap <silent> <F4>
\ :!ctags -f %:p:h/tags
\ --langmap="php:+.php"
\ -h ".php" -R --totals=yes 
\ --exclude="\.svn"
\ --exclude="*.js" 
\ --tag-relative=yes --PHP-kinds=+cf-v %:p:h <CR>

set tags=./tags,tags

"Start NERDTree
nmap <C-N>v :NERDTree<cr>
vmap <C-N>v <esc>:NERDTree<cr>i
imap <C-N>v <esc>:NERDTree<cr>i

nmap <C-N>x :NERDTreeClose<cr>
vmap <C-N>x <esc>:NERDTreeClose<cr>i
imap <C-N>x <esc>:NERDTreeClose<cr>i
"End NERDTree

"Start BufExplorer
nmap <C-F5> <Esc>:BufExplorer<cr>
vmap <C-F5> <esc>:BufExplorer<cr>
imap <C-F5> <esc>:BufExplorer<cr>
" F6 - previous buffer
nmap <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i
" F7 - next buffer
nmap <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>i
imap <F7> <esc>:bn<cr>i
"End BufExplorer

" F9 - paste mode
set pastetoggle=<F9>

" Class definition, methods and variables
nnoremap <silent> <F8> :TlistToggle<CR>
let tlist_php_settings = 'php;c:class;f:function'


" Save the file
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

" Line numeration
imap <F11> <Esc>:set<Space>nu!<CR>a
nmap <F11> :set<Space>nu!<CR>

set t_Co=256
set bg=dark
colorscheme desert256

syntax on
set title
set nocompatible
set autowrite

" Show partial commands as you type them
set showcmd

set laststatus=2
set statusline=%<%F\ %r%h%y[%{&ff}][%{&encoding}]%m%=%-13.(%5l_%3c%V%)%5LL%8.P


" Задать ширину строки
"set textwidth=79

if v:version >= 703
	" Подсвечивать границы
	set colorcolumn=80
endif
" Перенос по словам
set linebreak

" php helpfuls
" let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

set foldmethod=marker           "fdm:   looks for patterns of triple-braces in a file
set foldcolumn=4                "fdc:   creates a small left-hand gutter for displaying fold info

"do an incremental search
set showmatch
set hlsearch
set incsearch
set ignorecase
set wrapscan

" Correct indentation after opening a phpdocblock and automatic * on every line
set formatoptions=qroct

source ~/.vim/plugin/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

" Wrap visual selectiosn with chars
":vnoremap ( "zdi^V(<C-R>z)<ESC>
":vnoremap { "zdi^V{<C-R>z}<ESC>
":vnoremap [ "zdi^V[<C-R>z]<ESC>
":vnoremap ' "zdi'<C-R>z'<ESC>
":vnoremap " "zdi^V"<C-R>z^V"<ESC>

" Detect filetypes
"if exists("did_load_filetypes")
"    finish
"endif
augroup filetypedetect
    au! BufRead,BufNewFile *.pp     setfiletype puppet
    au! BufRead,BufNewFile *httpd*.conf     setfiletype apache
    au! BufRead,BufNewFile *inc     setfiletype php
augroup END

" Nick wrote: Uncomment these lines to do syntax checking when you save
"augroup Programming
" clear auto commands for this group
"autocmd!
"autocmd BufWritePost *.php !php -d display_errors=on -l <afile>
"autocmd BufWritePost *.inc !php -d display_errors=on -l <afile>
"autocmd BufWritePost *httpd*.conf !/etc/rc.d/init.d/httpd configtest
"autocmd BufWritePost *.bash !bash -n <afile>
"autocmd BufWritePost *.sh !bash -n <afile>
"autocmd BufWritePost *.pl !perl -c <afile>
"autocmd BufWritePost *.perl !perl -c <afile>
"autocmd BufWritePost *.xml !xmllint --noout <afile>
"autocmd BufWritePost *.xsl !xmllint --noout <afile>
"autocmd BufWritePost *.js !~/jslint/jsl -conf ~/jslint/jsl.default.conf -nologo -nosummary -process <afile>
"autocmd BufWritePost *.rb !ruby -c <afile>
"autocmd BufWritePost *.pp !puppet --parseonly <afile>
"augroup en

" enable filetype detection:
filetype on


"Autocomplit C-xC-o
autocmd FileType tt2html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Maps Omnicompletion to CTRL-space since ctrl-x ctrl-o is for Emacs-style RSI
inoremap <Nul> <C-x><C-p>
inoremap <Nul> <C-x><C-o>

" don't select first item, follow typing in autocomplete
set completeopt=longest,menuone,preview

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

"set ls=2            " allways show status line
set ruler           " show the cursor position all the time

"au BufNewFile,BufRead  *.pls    set syntax=dosini



if &term == "xterm-color"
  fixdel
endif

" Enable folding by fold markers
" this causes vi problems set foldmethod=marker 

" Correct indentation after opening a phpdocblock and automatic * on every
" line
set formatoptions=qroct



" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=~/.vim/phpfunclist.txt dictionary+=~/.vim/phpfunclist.txt
" Use the dictionary completion
set complete-=k complete+=k

" {{{ Autocompletion using the TAB key

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function InsertTabWrapper()
    let col = col('.') - 1
   if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" }}} Autocompletion using the TAB key


