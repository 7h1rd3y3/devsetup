" {{{,##Vim Options 
set exrc
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set expandtab
set smartcase
set number
set relativenumber
set scrolloff=10
set nowrap
set noswapfile
set nobackup
set noerrorbells
set nohlsearch
set hidden
set incsearch
set termguicolors
set noshowmode
set colorcolumn=100
set signcolumn
set cmdheight=2
set updatetime=50
set foldmethod=marker
set shortmess+=c
let map_leader = ","
" }}}


" {{{,##Vim Plugins 
call plug#begin('$HOME/.config/nvim/plugged')
    Plug 'aserowy/tmux.nvim'
    Plug 'dracula/vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'kevinoid/vim-jsonc'
    Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-fugitive'
    Plug 'ryanoasis/vim-devicons'
    Plug 'airblade/vim-gitgutter'
    Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'fladson/vim-kitty'

    " coc settings and snippets
    let g:coc_global_extensions = [
                \ 'coc-snippets',
                \ 'coc-pairs',
                \ 'coc-fish',
                \ 'coc-prettier',
                \ 'coc-json',
                \ 'coc-docker',
                \ 'coc-rls',
                \ 'coc-clangd',
                \ 'coc-sh',
                \ 'coc-go',
                \ 'coc-omnisharp',
                \ 'coc-python',
                \ 'coc-markdown-preview-enhanced',
                \ 'coc-webview',
                \ 'coc-markdownlint',
                \ ]

call plug#end()

" }))


" {{{,##Customizations
" Colors
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme dracula


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" tmux settings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Nerdtree
inoremap jk <ESC>
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" ###Customizations}}}
