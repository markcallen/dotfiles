"
"Based on https://dougblack.io/words/a-good-vimrc.html
"

" vim-plug - https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
" Don't forget to run :PlugInstall

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ctrlpvim/ctrlp.vim'      	" CtrlP is installed to support tag finding in vim-go
" Requires delve https://github.com/go-delve/delve/tree/master/Documentation/installation
Plug 'sebdah/vim-delve'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colours
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'

" Vim only plugins
if !has('nvim')
   Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Needed to make sebdah/vim-delve work on Vim
   Plug 'Shougo/vimshell.vim'              	" Needed to make sebdah/vim-delve work on Vim
endif

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" js formatting https://github.com/pangloss/vim-javascript
Plug 'pangloss/vim-javascript'
" jsx https://github.com/MaxMEllon/vim-jsx-pretty
Plug 'maxmellon/vim-jsx-pretty'

" CSS color highlighting
Plug 'ap/vim-css-color'

" Searching https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Eslint
Plug 'dense-analysis/ale'

call plug#end()

syntax on

set background=dark

silent! colorscheme badwolf

" Tab Handling
set tabstop=4
set softtabstop=4
set expandtab


" Show line numbers
set number

" Show command in bottom bar
set showcmd

" Highlight the current line
set cursorline

" load filetype-specific indent files
filetype indent plugin on

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to.
set lazyredraw

" highlight matching [{()}]
set showmatch

" search as characters are entered
set incsearch     	 
" highlight matches`
set hlsearch       	 


" from https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876
"----------------------------------------------
" Language: Golang
"----------------------------------------------
"Configure indentation
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" Code highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1

" Import dependencies
let g:go_fmt_command = "goimports"

" Linting with airline
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1


"----------------------------------------------
" Plugin: sebdah/vim-delve
"----------------------------------------------
" Set the Delve backend.
"let g:delve_backend = "native"

"----------------------------------------------
" Plugin: scrooloose/nerdtree
"----------------------------------------------
" Open with NERDTree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close VI is NERDTree is the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F2> :NERDTreeToggle<cr>

"----------------------------------------------
" Plugin: junegunn/fzf
"----------------------------------------------
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

"----------------------------------------------
" Plugin: dense-analysis/ale
"----------------------------------------------
"
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
