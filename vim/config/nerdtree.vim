"----------------------------------------------
" Plugin: scrooloose/nerdtree
"----------------------------------------------
" Open with NERDTree if no files specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close VI is NERDTree is the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowHidden=1
" Open filetree
map <leader>t :NERDTreeToggle<cr>
