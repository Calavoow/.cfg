" Automatic plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
	call plug#begin('~/.local/share/nvim/plugged')
else
	call plug#begin('~/.vim/plugged')
endif
" Sensible vim defaults
Plug 'tpope/vim-sensible'

" Solarized colorscheme
Plug 'lifepillar/vim-solarized8'

" Asynchronous processes
Plug  'Shougo/vimproc.vim', { 'do': 'make' }

" Ctrl-P
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax checks
Plug 'w0rp/ale'
" Plug 'scrooloose/syntastic'

" Repeat with .
Plug 'tpope/vim-repeat'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Marks
Plug 'kshenoy/vim-signature'

" Comments
Plug 'tpope/vim-commentary'

" Vim Surround
Plug 'tpope/vim-surround'

" Aligning
Plug 'junegunn/vim-easy-align'

" Snippets
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Completions
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Editorconfig for indenting and such
Plug 'editorconfig/editorconfig-vim'

" Language
Plug 'reedes/vim-wordy'

""
" Languages
""
" Latex
Plug 'lervag/vimtex', { 'for': 'tex' }

" Markdown 
Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax' 
" Julia
" Plug 'JuliaLang/julia-vim'
Plug 'fatih/vim-go', { 'for': 'go' }

" Javascript
Plug 'pangloss/vim-javascript'
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Coffeescript
Plug 'kchmck/vim-coffee-script', {'for': 'coffee' }

" F#
Plug 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}

" Julia
Plug 'JuliaEditorSupport/julia-vim'

" Elm
Plug 'ElmCast/elm-vim'

" Add plugins to &runtimepath
call plug#end()

syntax enable

" indenting
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent

" Enable the mouse
set mouse=a

" line no
set number
" Relative number
set relativenumber
autocmd FileType tex set norelativenumber

" scrolling (keep n lines visible beneath and above cursor)
set scrolloff=10

" always show the statusline
set laststatus=2

" local leader
let maplocalleader = "\\"

set background=light
set termguicolors
colorscheme solarized8
set guifont=Fira\ Mono\ Regular:h12

" highlight current line
set cursorline
au FileType tex setlocal nocursorline

" highlight char line
set cc=100
" Use fmt as external formatter
set formatprg=fmt\ -c\ -g\ 100\ -w\ 110

" highlight search results
set hlsearch
" incremental search
set incsearch
" Smart case searching
set ignorecase
set smartcase

" recognize _ as a word boundary
set iskeyword-=_


" O delay
set timeout ttimeoutlen=100

" Filetype specific options
filetype on
filetype indent on
filetype plugin on

" Save code folds
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Fold column
set foldcolumn=0

" Ingore filetypes
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.d,*.o,*.aux

" Turn off character concealment
set conceallevel=0


" yank to clipboard
if has("clipboard")
  " set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

"""
" Plugins
"""
" Automatic folding in Pandoc
let g:pandoc_no_folding = 1
" let g:pandoc_no_spans = 1
let g:pandoc_auto_format = 1
" set pdflatex enginer
let g:pandoc#command#latex_engine = 'pdflatex'
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#conceal#use = 0

map <LocalLeader>pdf :Pandoc pdf<Enter>
map <LocalLeader>pdf! :Pandoc! pdf<Enter>

"ctags lookup also in parent directories.
set tags=./tags;/

" Completion options
set completeopt=menu

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" Ctrl-p ignore folders
" let g:ctrlp_custom_ignore = {
" 	\ 'dir': '\v[\/](node_modules)',
"   \ }
" Fuzzy file finder (fzf)
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <c-p> :ProjectFiles<cr>

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" vimtex
let g:vimtex_complete_recursive_bib = 1
let g:vimtex_complete_close_braces = 1
" Disable `x imaps for math mode.
let g:vimtex_imaps_enabled = 0


if has('macunix')
	let g:vimtex_view_method = 'skim'
else
	let g:vimtex_view_method = 'zathura'
endif
let g:vimtex_view_automatic = 1
" let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'

" disable quickfix warnings
" let g:vimtex_quickfix_latexlog = {
" 	\ 'default' : 1,
" 	\ 'general' : 0,
" 	\ 'overfull' : 0,
" 	\ 'underfull' : 0
" 	\}
let g:vimtex_quickfix_latexlog = {
      \ 'default' : 1,
      \ 'general' : 1,
      \ 'references' : 1,
      \ 'overfull' : 1,
      \ 'underfull' : 1,
      \ 'font' : 1,
      \ 'packages' : {
      \   'default' : 1,
      \   'natbib' : 1,
      \   'biblatex' : 1,
      \   'babel' : 1,
      \   'hyperref' : 1,
      \   'scrreprt' : 1,
      \   'fixltx2e' : 1,
      \   'titlesec' : 1,
      \ },
      \}

let g:vimtex_quickfix_mode = 2

let g:vimtex_motion_matchparen = 0

" Compile rules
let g:vimtex_compiler_latexmk = {
\ 'build_dir' : 'build'
\}


" Quickfix typescript
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow

" Airline statusbar
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" Disable syntastic for certain types
let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': [],
			\ 'passive_filetypes' : ['typescript', 'go'] }
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_javascript_checkers = ['jshint']

" Vim Easy Align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-go
" Run commands such as go run for the current file with <leader>r or go build and go test for the
" current package with <leader>b and <leader>t respectively. Display beautifully annotated source code
" to see which functions are covered with <leader>c.
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" By default the mapping gd is enabled, which opens the target identifier in current buffer. You can
" also open the definition/declaration, in a new vertical, horizontal, or tab, for the word under your cursor:

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Open the relevant Godoc for the word under the cursor with <leader>gd or open it vertically with <leader>gv

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Or open the Godoc in browser

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Show a list of interfaces which is implemented by the type under your cursor with <leader>s

au FileType go nmap <Leader>s <Plug>(go-implements)

" Show type info for the word under your cursor with <leader>i (useful if you have disabled auto showing type info via g:go_auto_type_info)

au FileType go nmap <Leader>i <Plug>(go-info)

" Rename the identifier under the cursor to a new name

au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" Javascript, tern for vim
let g:tern_map_keys = 1

" Disable temp files for gopass password files
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" Set python3 path
let g:python3_host_prog = $HOME . '/.config/nvim/.venv/bin/python'
