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

call plug#end()

syntax on

set noswapfile

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

" open terminal below
"set splitbelow
"set termsize=10x0

"----------------------------------------------
" IDE
"----------------------------------------------
" Format file
map <F7> gg=G<C-o><C-o>
" Open filetree
map <F2> :NERDTreeToggle<cr>

" Powerline
let g:airline_powerline_fonts = 1
set t_Co=256

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

" Write file when :GoBuild is run
set autowrite

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
" Plugin: dense-analysis/ale
"----------------------------------------------
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

"----------------------------------------------                             
" Plugin: vim-airline/vim-airline                                           
"----------------------------------------------                             
let g:airline_theme='badwolf'                                               
let g:airline#extensions#tabline#enabled = 1                                
                                                                            
" This allows buffers to be hidden if you've modified a buffer.             
" This is almost a must if you wish to use buffers in this way.             
set hidden                                                                  
                                                                            
" note leader is mapped to \                                                
let g:airline#extensions#tabline#buffer_idx_mode = 1                        
nmap <leader>1 <Plug>AirlineSelectTab1                                      
nmap <leader>2 <Plug>AirlineSelectTab2                                      

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
" close current buffer
nnoremap <leader>c :bp\|bd #<CR>

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
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'
let g:ale_php_php_cs_fixer_executable='./vendor/bin/phpcbf'
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint'],
 \ 'typescript': ['prettier', 'eslint'],
 \ 'typescriptreact': ['prettier', 'eslint'],
 \ 'python': ['autopep8', 'yapf'], 
 \ 'json': ['fixjson'], 
 \ 'php': ['php_cs_fixer'],
 \ '*': ['prettier']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

"----------------------------------------------
" Plugin: vim-airline/vim-airline
"----------------------------------------------
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" note leader is mapped to \
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2

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
" Plugin: hashivim/vim-terraform
"----------------------------------------------
let g:terraform_align=1
let g:terraform_fmt_on_save=1

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
