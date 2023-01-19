#! /usr/bin/env bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source /home/odoo/.nvm/nvm.sh && nvm install 19.4.0

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p /home/odoo/.vim/backup
mkdir -p /home/odoo/.vim/swp

python3 -m pip install black

echo "" >> /home/odoo/.bashrc
echo 'export PATH=/home/odoo/.local/bin/black:$PATH' >> /home/odoo/.bashrc

cat << EOF > /home/odoo/.vimrc
call plug#begin('~/.vim/plugged')                                                       
  Plug 'sukima/xmledit', {'branch': 'master'}                                           
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'whatyouhide/vim-gotham'
call plug#end()                                                                         

let g:coc_disable_startup_warning = 1
silent! colorscheme gotham256

" ============================ begin coc ====================================
" allow coc.nvim to find the right node
let g:coc_node_path = '/home/odoo/.nvm/versions/node/v19.4.0/bin/node'
                                                                                        
" coc settings
" snippet expansion settings
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" show info on hover
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" navigate errors
try
    nmap <silent> <Leader>n :call CocAction('diagnosticNext')<cr>
    nmap <silent> <Leader>b :call CocAction('diagnosticPrevious')<cr>
endtry
" ============================ end coc ====================================

" ======================= begin generic vim ===============================
"
filetype plugin on
syntax on

"
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

" use mouse wheel to scroll popup
set mouse=a

" generic vim settings
set colorcolumn=88                                                                      
set hlsearch                                                                            
set termguicolors
set nowrap                                                                              
set nu                                                                                  
set tabstop=2                                                                           
set softtabstop=2                                                                       
set shiftwidth=2                                                                        
set textwidth=0                                                                         
set expandtab                                                                           
set autoindent                                                                          
set fileformat=unix
" ======================= end generic vim ================================

" ===================== begin python specific  ===========================
autocmd BufWritePre *.py silent! :CocCommand pyright.organizeimports
" ====================== end python specific  ===========================
"
EOF

cat << EOF > /home/odoo/.vim/coc-settings.json
{
  "python.formatting.provider": "black",
  "python.formatting.blackPath": "/home/odoo/.local/bin/black",
  "coc.preferences.formatOnSaveFiletypes": [
    "python",
    "json"
  ]
}
EOF

