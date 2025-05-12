"----------------------------------------------
" Plugin: dense-analysis/ale
"----------------------------------------------
"
let g:airline#extensions#ale#enabled = 1
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'
let g:ale_php_php_cs_fixer_executable='./vendor/bin/phpcbf'
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint'],
 \ 'typescript': ['prettier', 'eslint'],
 \ 'typescriptreact': ['prettier', 'eslint'],
 \ 'python': ['autopep8', 'yapf'], 
 \ 'json': ['fixjson', 'prettier'], 
 \ 'php': ['php_cs_fixer'],
 \ 'terraform': ['terraform'],
 \ '*': ['prettier']
 \ }
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#1c1b1a
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#1c1b1a
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
