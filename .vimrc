:filetype plugin on

syntax on
set nocompatible

set autowrite
set nobackup                    "bk:    does not write a persistent backup file of an edited file
set writebackup                 "wb:    does keep a backup file while editing a file
set hidden "persist undo history
set autoread "re-read file has been changed automaticaly

set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

set encoding=utf-8
set fileencoding=utf-8

let Grep_Skip_Dirs = '.svn'

set t_Co=256
set bg=dark
colorscheme desert256

" Line width
"set textwidth=79

if v:version >= 703
	" Highlight line bounds
	set colorcolumn=80
	"set mouse=a
endif
" Line break
set linebreak

set title
" Show partial commands as you type them
"
set showcmd

set ruler           " show the cursor position all the time
set laststatus=2	" allways show status line
set statusline=
set statusline+=%<%F\ " filename
set statusline+=%M\ "modified flag
set statusline+=Line:%l/%L\ " line position, total, percents
set statusline+=Col:%c\ " column number
set statusline+=Buf:%-10.3n " buffer number
set statusline+=%r%h%y " status flags
set statusline+=[%{&ff}][%{&encoding}] " file type and encoding

"set list "Show tabs, end of line etc.
"set listchars=tab:▸\ ,eol:¬ 
set listchars=tab:→\ ,eol:¬,trail:· 

set foldmethod=marker           "fdm:   looks for patterns of triple-braces in a file
"set foldclose=all				" Autoclose folds, when moving out of them
set foldcolumn=4                "fdc:   creates a small left-hand gutter for displaying fold info

set scrolljump=5 				" Jump 5 lines when running out of the screen
set scrolloff=3					" Indicate jump out of the screen when 3 lines before end of the screen

" Repair wired terminal/vim settings
set backspace=start,eol,indent

" Allow file inline modelines to provide settings
set modeline

" Enable folding by fold markers
" this causes vi problems 
" set foldmethod=marker 

" Correct indentation after opening a phpdocblock and automatic * on every line
set formatoptions=qroct

" Turns on auto indentation
set ai
set ci

set autoindent 
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround                  "sr:    rounds indent to a multiple of shiftwidth
set smarttab
"set et
"set wrapmargin=89


"do an incremental search
set showmatch
set hlsearch
set incsearch
set ignorecase
set wrapscan
set smartcase


" Allow undoing insert-mode ctrl-u and ctrl-w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Shortcut to add new blank line without entering insert mode
noremap ,<CR> :put_<CR>
"Ctags background scan
nmap <silent> <F4>
\ :!ctags -f %:p:h/tags
\ --links="yes"
\ --langmap="php:+.php"
\ -h ".php" -R --totals=yes 
\ --exclude="\.svn"
\ --exclude="*.js" 
\ --tag-relative=yes --PHP-kinds=+cfiv %:p:h <CR>

set tags=./tags,tags

"Start NERDTree
nmap <F12> :NERDTreeToggle<cr>
vmap <F12> <esc>:NERDTreeToggle<cr>
imap <F12> <esc>:NERDTreeToggle<cr>
"End NERDTree

map <F1> :vimgrep /todo/j *.php<CR>:cw<CR>
nmap <silent> <F3> :set list!<CR>

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

" php helpfuls
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

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
    au! BufRead,BufNewFile *.phtml     setfiletype php
augroup END

" Nick wrote: Uncomment these lines to do syntax checking when you save
"augroup Programming
" clear auto commands for this group
"autocmd!
:autocmd FileType php noremap <C-L> :!php -l %<CR>
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

"au BufNewFile,BufRead  *.pls    set syntax=dosini

if &term == "xterm-color"
  fixdel
endif

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
" curl -o ~/.vim/phpfunclist.txt -v http://lerdorf.com/funclist.txt
set dictionary-=~/.vim/phpfunclist.txt dictionary+=~/.vim/phpfunclist.txt
" Use the dictionary completion
set complete-=k complete+=k

" MovingThroughCamelCaseWords
nnoremap <silent><C-Left> :<C-u>cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left> <C-o>:cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:cal search('\<\<Bar>\U\@<=\u\<Bar>\u\ze\%(\U\&\>\@!\)\<Bar>\%$','W')<CR>

" {{{ Autocompletion using the TAB key

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
"function InsertTabWrapper()
    "let col = col('.') - 1
   "if !col || getline('.')[col - 1] !~ '\k'
        "return "\<tab>"
    "else
        "return "\<c-p>"
    "endif
"endfunction

" Remap the tab key to select action with InsertTabWrapper
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" }}} Autocompletion using the TAB key
