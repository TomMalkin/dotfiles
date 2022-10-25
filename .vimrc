set nocompatible

filetype off

" --- Vundle Setup ---

" linux
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" windows
" set rtp+=$HOME/.vim/bundle/Vundle.vim/
" call vundle#being('$HOME/.vim/bundle/')

Plugin 'VundleVim/Vundle.vim'

" ---------
"  Plugins
" ---------

" --- filetree ---
Plugin 'preservim/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree


Plugin 'easymotion/vim-easymotion'

" --- Python ---
"Plugin 'davidhalter/jedi-vim'
"Plugin 'psf/black'
Plugin 'Vimjas/vim-python-pep8-indent'
"Plugin 'nvie/vim-flake8'
"let g:flake8_show_in_file=1

Plugin 'dense-analysis/ale'
"let g:ale_fixers = {
    "\'*': ['remove_trailing_lines', 'trim_whitespace'],
    "\'python': ['black'],
    "\}
 
let g:ale_linters = {'python': 'all'}
let g:ale_fixers = {'python': ['isort', 'black', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_lsp_suggestions = 1
"let g:ale_fix_on_save = 1
"let g:ale_go_gofmt_options = '-s'
"let g:ale_go_gometalinter_options = '— enable=gosimple — enable=staticcheck'
let g:ale_completion_enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %code: %%s'

" --- Web ---
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'

" --- Search ---
Plugin 'kien/ctrlp.vim'

" --- automatic bracket pairs ---
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" --- defaults polyglot ---
"Plugin 'sheerun/vim-polyglot'
Plugin 'scrooloose/nerdcommenter'
Plugin 'alvan/vim-closetag'

" --- status bar ---
Plugin 'vim-airline/vim-airline'

" --- distraction free options ---
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

" --- Prose ---
Plugin 'reedes/vim-pencil'

" --- Colour Scheme ---
Plugin 'morhetz/gruvbox'

" --- convenience ---
Plugin 'tpope/vim-unimpaired'


" --- Rust IDE ---
"Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on

" ---------------
"  Configuration
" ---------------

" Change the directory of the swp and backup files
set directory=$HOME/.vim/swapfiles
set backupdir=$HOME/.vim/backup

" Enable folding
set foldmethod=indent
set foldlevel=100

" general language syntax
syntax on

" hybrid line numbers that toggle on focus
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup End

" enable mouse
set mouse=a

" enable normal backspace
set backspace=indent,eol,start

" highlight currentline
highlight CursorLine ctermbg=DarkGrey

" --- Python Configuration ---
let python_highlight_all=1
set ts=4
set autoindent
set expandtab
set shiftwidth=4
" set cursorline
set showmatch
set encoding=utf-8


" --- Long Line Indicators ---
" ruler
autocmd FileType python setlocal cc=101
highlight ColorColumn ctermbg=darkred ctermfg=white guifg=white

" highlight over long lines
autocmd FileType python match OverLength /\%>100v.\+/
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9


" --- Key mappings ---
let mapleader=","
nnoremap <space> za  " fold with the spacebar

" tabs
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" toggle filetree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

map <leader>d :ALEGoToDefinition<CR>
map <leader>r :ALEFindReferences<CR>
map <leader>h :ALEHover<CR>
map <leader>j :ALENextWrap<CR>
map <leader>k :ALEPreviousWrap<CR>
nnoremap <F9> :ALEFix<CR>

map <leader>h :ALEFix<CR>

" run Black
"nnoremap <F9> :Black<CR>

" Prose Settings for limelight plugin
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" define our prose writing settings
function! ProseMode()
    ":set colorcolumn=101
    "":set tw=100
    set spell spelllang=en_au
    Goyo 100
    SoftPencil
    Limelight
    set nonumber norelativenumber
    augroup numbertoggle
        autocmd!
    augroup End
    let g:airline_focuslost_inactive = 1
    syntax off
endfunction

" define our code writing settings
function! CodeMode()
    Goyo!
    NoPencil
    Limelight
    set nospell
    set number relativenumber
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup End
    let g:airline_focuslost_inactive = 0
endfunction

autocmd vimenter * ++nested colorscheme gruvbox
set background=dark


set textwidth=100

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
