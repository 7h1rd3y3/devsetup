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
    " LSP Plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    Plug 'onsails/lspkind-nvim'
    Plug 'nvim-lua/lsp_extensions.nvim'
    
    " For some pretty colors
    Plug 'gruvbox-community/gruvbox'

    " Need Treesitter for telescope
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'romgrk/nvim-treesitter-context'

    " Telescopes
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

colorscheme gruvbox
" }))

" {{{,## LSP 
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" }}}

" {{{,##GIT 
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
" }}}

