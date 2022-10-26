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
 \ 'json': ['fixjson'], 
 \ 'php': ['php_cs_fixer'],
 \ '*': ['prettier']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
