"----------------------------------------------
" Plugin: vim-airline/vim-airline
"----------------------------------------------
set t_Co=256
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2

let g:airline_powerline_fonts = 1
