"  __  __  ___   _
" |  \/  |/ __| /_\
" | |\/| | (__ / _ \
" |_|  |_|\___/_/ \_\
"
" @markcallen
"

syntax on

set encoding=utf-8
scriptencoding utf-8

set completeopt=menuone,noinsert,noselect
set splitbelow
set splitright

set noswapfile
set hidden

set background=dark

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set relativenumber
set number

set spell

set list
set listchars=trail:·,tab:»·

set scrolloff=4
set sidescrolloff=4

set showcmd
set cursorline

set diffopt+=vertical

set wildmenu
set lazyredraw
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch

set autowrite

set updatetime=300
set signcolumn=yes

set term=xterm-256color

filetype indent plugin on

if (has("termguicolors"))
  set termguicolors
endif

let g:netrw_banner=0
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript']

let $RC="$HOME/.vimrc"

map <leader>ve :e $RC<cr>
map <leader>vs :so $RC<cr>

nnoremap <leader>c :bp\|bd #<CR>

" Format file
map <F7> gg=G<C-o><C-o>

"----------------------------------------------
" Plugins
"----------------------------------------------

" vim-plug - https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
" Don't forget to run :PlugInstall

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Colours
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'

"vim-fugitive https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

" Conquer of Completion (coc) https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ctrlpvim/ctrlp.vim' " CtrlP is installed to support tag finding in vim-go
" Requires delve https://github.com/go-delve/delve/tree/master/Documentation/installation
Plug 'sebdah/vim-delve'

" Vim only plugins
if !has('nvim')
   Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Needed to make sebdah/vim-delve work on Vim
   Plug 'Shougo/vimshell.vim'              	" Needed to make sebdah/vim-delve work on Vim
endif

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

" Go through VIM registries https://github.com/bfredl/nvim-miniyank
"Plug 'bfredl/nvim-miniyank' commented out due to bugs in OSX

" PHP Syntax https://github.com/StanAngeloff/php.vim
Plug 'StanAngeloff/php.vim'

" Terraform https://github.com/hashivim/vim-terraform
Plug 'hashivim/vim-terraform'

" indentLine https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

" jsx typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" vim-gitgutter https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter', {'branch': 'main'}

call plug#end()

silent! colorscheme badwolf
source ~/.vim/config/airline.vim
source ~/.vim/config/ale.vim
source ~/.vim/config/coc.vim
source ~/.vim/config/terraform.vim
source ~/.vim/config/gitgutter.vim
source ~/.vim/config/nerdtree.vim

" still working below here


"----------------------------------------------
" IDE
"----------------------------------------------

" completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" indentLine character
let g:indentLine_char = '⦙'

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

" Debug window
let g:go_debug_windows = {
          \ 'vars':       'leftabove 30vnew',
          \ 'stack':      'leftabove 20new',
          \ 'out':        'botright 5new',
\ }

" GoBuild navigation
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" from https://realpython.com/vim-and-python-a-match-made-in-heaven/
"----------------------------------------------
" Language: Python
"----------------------------------------------
"Configure indentation
au BufNewFile, BufRead *.py
                        \ set tabstop=4
                        \ set softtabstop=4
                        \ set shiftwidth=4
                        \ set textwidth=79
                        \ set expandtab
                        \ set autoindent
                        \ set fileformat=unix
                        \ set filetype=python

autocmd FileType python colorscheme gruvbox

"----------------------------------------------
" Language: javascript
"----------------------------------------------
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=2 sts=2 sw=2

"----------------------------------------------
" Language: php
"----------------------------------------------
autocmd FileType php setlocal ts=2 sts=2 sw=2

"----------------------------------------------
" Language: yaml
"----------------------------------------------
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"----------------------------------------------
" Language: json
"----------------------------------------------
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab

"----------------------------------------------
" Plugin: sebdah/vim-delve
"----------------------------------------------
" Set the Delve backend.
"let g:delve_backend = "native"

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
" Plugin: bfredl/nvim-miniyank
"----------------------------------------------
"map p <Plug>(miniyank-autoput)
"map P <Plug>(miniyank-autoPut)
"map <leader>p <Plug>(miniyank-startput)
"map <leader>P <Plug>(miniyank-startPut)
"map <leader>n <Plug>(miniyank-cycle)
"map <leader>N <Plug>(miniyank-cycleback)


"----------------------------------------------
" Plugin: peitalin/vim-jsx-typescript
"----------------------------------------------

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

hi ReactState guifg=#C176A7
hi ReactProps guifg=#D19A66
hi ApolloGraphQL guifg=#CB886B
hi Events ctermfg=204 guifg=#56B6C2
hi ReduxKeywords ctermfg=204 guifg=#C678DD
hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
hi WebBrowser ctermfg=204 guifg=#56B6C2
hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66
