" Not vi compatible
set nocompatible

"----------NeoVim--------------"

if has('nvim')
  let s:editor_root=expand('~/.config/nvim')
else
  let s:editor_root=expand('~/.vim')
endif





"----------Plugin-Setup----------"

" Automatic setup
if empty(glob(s:editor_root . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . s:editor_root . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      autocmd VimEnter * PlugInstall
    endif





" Insert plugins between tags
call plug#begin(s:editor_root . '/plugged')
"----------Plugins----------"

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
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'html.handlebars'] }

" Intellisense completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Comments
Plug 'tpope/vim-commentary'
Plug 'kevinoid/vim-jsonc'

" Fuzzy search (install fzf using git clone, install ripgrep via brew)
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'

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
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {},
  },
}
EOF
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'w0rp/ale' " Asynchronous linting
Plug 'joukevandermaas/vim-ember-hbs' " Ember handlebars syntax

" Toggle boolean values
Plug 'https://github.com/sagarrakshe/toggle-bool'

" GraphQL support for Vim
Plug 'jparise/vim-graphql'

" Postgres highlighting
Plug 'darold/pgFormatter'





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
set wrap linebreak
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
nnoremap <leader><space> :noh<cr>

" Highlight colors
set hlsearch
hi Search ctermbg=LightGreen
hi Search ctermfg=Black





"----------Key bindings----------"

" Leader (spacebar) remaps
let mapleader="\<space>"
let maplocalleader=','

" Map Enter <leader> in normal mode as well
nmap <cr> <leader>

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

" Split windows on leader
nnoremap <leader>vs :vs<cr>
nnoremap <leader>sp :sp<cr>

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
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-ember',
  \ 'coc-eslint',
  \ 'coc-fzf-preview',
  \ 'coc-git',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-yaml'
\ ]

"""Recommended config
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"""Tab to trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"""Ctrl+space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

""" Make <CR> auto-select the first completion item and notify coc.nvim to
""" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""" Use `[g` and `]g` to navigate diagnostics
""" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

""" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

""" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

""" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

""" Code action on selected line
nnoremap <leader>a <Plug>(coc-codeaction-line)

""" Organize imports
nnoremap <leader>oi :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

""" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" /coc.nvim

" FZF - fe refers to file explorer
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


" Auto Pairs
let g:AutoPairsShortcutBackInsert = '<c-b>'

" Reformat upon save with Ale / Prettier
let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'css': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'json': ['prettier'],
  \ 'html.handlebars': ['prettier']
  \}
let g:ale_fix_on_save = 1

" Force reformat
noremap <leader>pret :Prettier<cr>

" Boolean Toggle
noremap <leader>bt :ToggleBool<cr>

" Restart coc.vim
nnoremap <leader>cocr :CocRestart<cr>

" Syntax highlighting
let g:yats_host_keyword = 1

" Use pgFormatter with gq commands
au FileType sql setl formatprg=/usr/local/Cellar/perl/5.28.1/bin/pg_format\ -





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
