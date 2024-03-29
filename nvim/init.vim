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

" Color schemes
Plug 'morhetz/gruvbox'
" Plug 'tomasiser/vim-code-dark' "codedark

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
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'leafgarland/typescript-vim'
Plug 'joukevandermaas/vim-ember-hbs'

" LSP
Plug 'kosayoda/nvim-lightbulb'





call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"bash", "css", "glimmer", "go", "html", "javascript", "jsdoc", "json", "comment", "lua", "regex", "tsx", "typescript", "vue"},
  highlight = {
    enable = true,
    disable = {},
  },
}
EOF

"----------Basic-config----------"

" Encoding
if !has('nvim')
  set encoding=UTF-8
endif

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

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Disable paste mode when leaving insert mode
autocmd InsertLeave * set nopaste





"----------Visuals----------"

" Syntax highlighting
syntax on
autocmd vimenter * ++nested colorscheme gruvbox
hi HighlightedyankRegion term=bold ctermbg=0 guibg=#31D57C
set nospell "Turns off annoying red text from spellchecker

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
nnoremap <leader>nm :noh<cr>

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
nmap <leader>ce :tabedit $HOME/.config/nvim/init.vim<cr>

" Quick yank full path
nmap <leader>cp :let @+=expand('%:p')<cr>

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

" Open yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Git Fugitive
map <leader>gb :Git blame<CR>
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>





"----------Plugin Settings----------"

" Airline
set laststatus=2
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled=1
let airline_theme='hybridline'

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
let g:coc_disable_startup_warning = 1
let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-browser',
  \ 'coc-css',
  \ 'coc-cssmodules',
  \ 'coc-dash-complete',
  \ 'coc-ember',
  \ 'coc-eslint',
  \ 'coc-fzf-preview',
  \ 'coc-git',
  \ 'coc-glint',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-html-css-support',
  \ 'coc-htmlhint',
  \ 'coc-json',
  \ 'coc-lightbulb',
  \ 'coc-lists',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-solargraph',
  \ 'coc-stylelint',
  \ 'coc-stylelintplus',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-xml',
  \ 'coc-yank'
\ ]

"""Recommended config
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>a  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" FZF - fe refers to file explorer
nnoremap <silent> <expr> <Leader>fe (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
nnoremap <silent> <expr> <leader>bb (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Buffers\<cr>"
nnoremap <silent> <expr> <leader>rg (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Rg\<cr>"

" Exclude filenames from ripgrep: Disable while not in use
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Nerd Tree
nnoremap <leader>nt :NERDTreeToggle<cr>

""" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

""" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

""" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

autocmd FileType nerdtree setlocal relativenumber
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw=0
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1

" Multi Cursor
let multi_cursor_insert_maps={'j':1}

" Easy align
let g:easy_align_ignore_groups=['String']
xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

" Reformat upon save with coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_filetype_map = {
      \ 'html.handlebars': 'handlebars',
      \ }

" Force reformat
noremap <leader>pr :CocCommand prettier.formatFile<cr>

" Restart coc.vim
nnoremap <leader>cr :CocRestart<cr>

" Swap directory
set dir=~/.local/share/nvim/swap/

" Disable Perl not installed warning
let g:loaded_perl_provider = 0

" Show lightbulb if code action available at cursor position
autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()

" Autocomplete via copilot
imap <silent><script><expr> <S-tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true





"----------Auto-commands----------"

" Reload vim on save
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END

" Autoreload externally edited file
augroup autoreload
  autocmd!
  autocmd CursorHold,CursorHoldI * silent! checktime
augroup END
