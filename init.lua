
vim.cmd [[
let mapleader=" "
let maplocalleader="\\"

set nocompatible
set showmatch
set number
set relativenumber
set filetype
set incsearch
set hlsearch
set clipboard=unnamed,unnamedplus
set noswapfile
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set guifont=Fira\ Code:h10
set ttyfast
set cc=80
set ignorecase
set wildmode=longest,list
set signcolumn=yes " number
set updatetime=100
set termguicolors
set smartindent

filetype plugin indent on
filetype plugin on
syntax on

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

noremap ge G
noremap gs ^
noremap s h
noremap gl $
noremap U <C-r>
noremap d x
noremap gp <C-o>
noremap gn <C-i>

]]

require("config.lazy")
require("config.lsp")
