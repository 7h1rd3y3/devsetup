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
let map_leader = " "
" }}}


" {{{,##Vim Plugins 
call plug#begin('~/.config/nvim/plugged')
    Plug 'dracula/vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'kevinoid/vim-jsonc'
    Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" }))


" {{{,##Customizations
" Colors
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme dracula

" coc settings and snippets

" tmux settings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" ###Customizations}}}
