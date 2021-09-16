" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
Plug 'ncm2/ncm2'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'phpactor/ncm2-phpactor'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'

Plug 'Rican7/php-doc-modded'
"Plug 'arnaud-lb/vim-php-namespace'
"Plug 'vim-scripts/taglist.vim'
Plug 'preservim/tagbar'
Plug 'sudar/comments.vim'

" Initialize plugin system
call plug#end()


syntax on
set nocompatible

set autowrite
set nobackup                    "bk:    does not write a persistent backup file of an edited file
set writebackup                 "wb:    does keep a backup file while editing a file
set hidden "persist undo history
set autoread "re-read file has been changed automaticaly

set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" set encoding=utf-8
" set fileencoding=utf-8

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
"set foldcolumn=4                "fdc:   creates a small left-hand gutter for displaying fold info

set scrolljump=5 				" Jump 5 lines when running out of the screen
set scrolloff=3					" Indicate jump out of the screen when 3 lines before end of the screen

" Repair wired terminal/vim settings
set backspace=start,eol,indent

" Allow file inline modelines to provide settings
set modeline

" Correct indentation after opening a phpdocblock and automatic * on every line
set formatoptions=qroct

" Turns on auto indentation
set ai
set ci

set autoindent
set expandtab        "replace <TAB> with spaces
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround                  "sr:    rounds indent to a multiple of shiftwidth
set smarttab


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

" delete trailing space when saving files
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
    retab
endfunc

autocmd BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc :call DeleteTrailingWS()


"" Set the PHP bin to an additional installation that has no XDEBUG installed
let g:phpactorPhpBin = '/opt/lampp/bin/php'

"" Make ncm2 work automatically
let g:python3_host_prog='/usr/bin/python3'
autocmd BufEnter * call ncm2#enable_for_buffer()

"" When autocompleting auto select the first one and do not autoinsert.
set completeopt=noinsert,menuone

"" Enable tab cyle thorought suggestions.
"" ctrl + j: Next item (down).
"" ctrl + k: Previous item (up).
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"" When pressing CTRL+u on a suggestion, it will expand with parameters.
"" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

"" Tab and Shift-Tab will cycle thorough parameters.
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" ALE
let g:ale_fix_on_save = 0
let g:ale_lint_delay = 1000
let b:ale_warn_about_trailing_whitespace = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

let g:ale_fixers = {
      \   'php': ['phpcbf'],
      \}
let g:ale_linters = {
      \   'php': ['php', 'phpcs'],
      \}
let g:ale_php_phpcbf_standard = 'PSR12'
let g:ale_php_phpcs_standard = 'PSR12'

nnoremap <leader>f :ALEFix<cr>

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

"function! IPhpInsertUse()
"    call PhpInsertUse()
"    call feedkeys('a',  'n')
"endfunction
"autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
"autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

nnoremap <silent> gd :call phpactor#GotoDefinition()<CR>
nnoremap <silent> fr :call phpactor#FindReferences()()<CR>

"Start NERDTree
nmap <F12> :NERDTreeToggle<cr>
vmap <F12> <esc>:NERDTreeToggle<cr>
imap <F12> <esc>:NERDTreeToggle<cr>

nnoremap <leader>T :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>

"let g:NERDTreeWinPos = "right"
"End NERDTree

map <F1> :vimgrep /todo/j *.php<CR>:cw<CR>
nmap <silent> <F3> :set list!<CR>

"Start BufExplorer
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc>:BufExplorer<cr>
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
"nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
" let tlist_php_settings = 'php;c:class;f:function'
"let Tlist_Use_Right_Window   = 1
" let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Show_One_File = 1

" Save the file
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

" Line numeration
imap <F11> <Esc>:set<Space>nu!<CR>a
nmap <F11> :set<Space>nu!<CR>

:nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
:nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
