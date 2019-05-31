" Not vi compatible
set nocompatible

"----------NeoVim--------------"

if has('nvim')
  let s:editor_root=expand('~/.config/nvim')
else
  let s:editor_root=expand('~/.vim')
endif

"----------Plugins----------"

" Automatic plugin setup
if empty(glob(s:editor_root . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . s:editor_root . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      autocmd VimEnter * PlugInstall
    endif

" Insert plugins between tags

call plug#begin(s:editor_root . '/plugged')

" CodeDark color scheme
Plug 'tomasiser/vim-code-dark'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Spacing
Plug 'ntpeters/vim-better-whitespace'
Plug 'nathanaelkane/vim-indent-guides'

" Formatting
Plug 'editorconfig/editorconfig-vim'

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Intellisense completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" Snippets
Plug 'SirVer/ultisnips'

" Comments
Plug 'tpope/vim-commentary'

" Fuzzy search (install fzf using git clone, install ripgrep via brew)
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

" Better / search (not sure how to use this yet)
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'

" File browsing
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'

" Motions
Plug 'Lokaltog/vim-easymotion'

" Text objects
Plug 'tpope/vim-repeat' " Better repeating than just native commands
Plug 'tpope/vim-surround' " For changing surrounding tags?
Plug 'tpope/vim-unimpaired' " Mappings?

" Alignment
Plug 'junegunn/vim-easy-align', { 'on': ['<plug>(EasyAlign)', 'EasyAlign'] }

" Auto-close parenthesis/brackets/pairs
Plug 'jiangmiao/auto-pairs'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Syntaxes
Plug 'sheerun/vim-polyglot' " Support for multiple languages
Plug 'ElmCast/elm-vim' " Syntax highlighting, auto-indents, etc
Plug 'w0rp/ale' " Asynchronous linting

" Toggle boolean values
Plug 'https://github.com/sagarrakshe/toggle-bool'

" GraphQL support for Vim
Plug 'jparise/vim-graphql'

" Vim-Plug
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'





call plug#end()
"----------Basic-config----------"

" Encoding
if !has('nvim')
  set encoding=utf-8
endif

" Syntax highlighting
syntax on
  colorscheme codedark

" Enable mouse support & hide while typing
set mouse=a
set mousehide

" Code folding off (not sure how I could use this yet)
set nofoldenable

" Expected backspace functionality
set backspace=indent,eol,start

" Indent settings per filetype
filetype plugin indent on "(turns on detection, plugin, and indent all at once)

" Default split management
set splitbelow
set splitright

" Case insensitive search unless uppercase is typed
set ignorecase
set smartcase

" Soft wordwrap
set wrap linebreak nolist
set textwidth=0
set wrapmargin=0
set colorcolumn=0

" Indentation
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2

" Allow for cursor beyond last character
set virtualedit=onemore

" Spell check
set spell

" Switch buffers without saving
set hidden

" End of word designators
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set iskeyword-=_

" copy/paste
set clipboard^=unnamed,unnamedplus

" Ignore whitespace in vimdiff
set diffopt=iwhite

" Autosave when focus is lost
:au FocusLost * :wa

" Save swap files outside of normal directories
set swapfile
set dir=~/tmp

" Live substitution
:set inccommand=nosplit

" Start editing a new file in insert mode
autocmd BufNewFile * startinsert




"----------Visuals----------"

" Default numbering globally and in help file
autocmd FileType help setlocal number relativenumber
set number relativenumber

" Airline already shows the mode
set noshowmode

" Show matching brackets/parentheses
set showmatch

" Highlight cursor line
set cursorline
hi CursorLine term=NONE cterm=bold guibg=white

" Show whitespace characters
set listchars=tab:>·

" Enable autocompletion for command menu
set wildmenu

" Search as characters are entered
set incsearch

" Highlight last inserted text
nnoremap gV `[v`]

" Clear search highlighting
nnoremap <Leader><space> :noh<cr>

" Highlight colors
set hlsearch
hi Search ctermbg=LightGreen
hi Search ctermfg=Black





"----------Key bindings----------"

" Leader (spacebar) remaps
let mapleader="\<space>"
let maplocalleader=','

" Pasting without finger contortion
set pastetoggle=<f12>

" Wrapped lines go down/up to next row, rather than next line in file
noremap j gj
noremap k gk

" Quick config edit
nmap <leader>ce :tabedit $HOME/code/dotfiles/nvim/.vimrc<cr>

" Prevent F1 from opening help file without disabling it (remapped to ESC)
noremap <F1> <Esc>

" Saving with CTRL-S
command! W w
nnoremap <c-s> :w<cr>
inoremap <c-s> <ESC> :w<cr>
vnoremap <c-s> <ESC> :w<cr>

" Closing out with CTRL-Q
command! WQ wq
command! Wq wq
command! Q q
nnoremap <c-q> :q<cr>
inoremap <c-q> <esc> :q<cr>
vnoremap <c-q> <esc> :q<cr>

" Execute javascript using node
map <F8> :!node %<cr>

" Easier escape
inoremap fd <esc>
vnoremap fd <esc>

" Easier <c-[>
noremap <c-g> <c-[>

" Easier colon
nnoremap ; :
vnoremap ; :
nnoremap ;; ;
vnoremap ;; ;

" quick eol colon (adds a semicolon at the end of the line)
inoremap <leader>; <c-o>m`<c-o>A;<c-o>``
nnoremap <leader>; m`A;<esc>``
inoremap <leader>, <c-o>m`<c-o>A,<c-o>``
nnoremap <leader>, m`A,<esc>``

" Remap macros to something other than q
nnoremap m q
nnoremap q <nop>

" Stay in visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" Resize splits with arrow keys (based on newest window)
nnoremap <Up> :resize +5<cr>
nnoremap <down> :resize -5<cr>
nnoremap <left> :vertical resize +5<cr>
nnoremap <right> :vertical resize -5<cr>

" Move to beginning / end of line (and remove old bindings)
nnoremap B ^
nnoremap ^ <nop>
nnoremap E $
nnoremap $ <nop>

" Change between windows without using <c-w>
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" Rebinding deoplete movements up/down
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-k>"

" Quick sorting
vnoremap <leader>sa :sort<cr>
vnoremap <leader>sd :sort!<cr>





"----------Plugin Settings----------"

" Airline
set laststatus=2
let airline_theme='hybridline'
let airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Better whitespace
let strip_whitespace_on_save=1

" Indent guides
let indent_guides_enable_on_vim_startup=1
let indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgrey

" EditorConfig override
let g:EditorConfig_disable_rules = ['max_line_length']

" coc.nvim
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" FZF - fe refers to file explorer / nt refers to nerdtree
nnoremap <silent> <expr> <Leader>fe (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
nnoremap <silent> <expr> <leader>bb (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Buffers\<cr>"
nnoremap <silent> <expr> <leader>rg (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Rg\<cr>"

" Nerd Tree
nnoremap <leader>nt :NERDTreeToggle<cr>
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd FileType nerdtree setlocal relativenumber
let NERDTreeHijackNetrw=0
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1

" Multi Cursor
let multi_cursor_insert_maps={'j':1}

" Easy align
let g:easy_align_ignore_groups=['String']
xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

" Polyglot
let g:polyglot_disabled = ['elm']

" Auto Pairs
let g:AutoPairsShortcutBackInsert = '<c-b>'

" Reformat upon save with Ale / Prettier
let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'css': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'json': ['prettier']
  \}
let g:ale_fix_on_save = 1

" Boolean Toggle
noremap <leader>bt :ToggleBool<cr>

" Restart coc.vim
nnoremap <leader>cocr :CocRestart<cr>





"----------Auto-commands----------"

" Reload vim on save
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END

" Autoreload externally edited file
augroup autoreload
  autocmd!
  autocmd CursorHold,CursorHoldI * checktime
augroup END
