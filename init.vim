:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set ic
:set hls is
:set showmode
:set history=1000
:set wildmenu
:set wildignore=*.docx,*.xlsx,*.png,*.jpg,*.pdf,*.exe,*.img
:set termguicolors
:set encoding=UTF-8

":GitGutterEnabled
":GitGutterSignsToggle
":GitGutterLineHighlightsToggle

syntax on
filetype on
filetype plugin on
filetype plugin indent on

call plug#begin()
Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'othree/html5.vim'
Plug 'rust-lang-nursery/rustfmt'
Plug 'https://github.com/lepture/vim-jinja'
Plug 'rust-lang/rust.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'quramy/tsuquyomi'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'Xuyuanp/scrollbar.nvim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'preservim/nerdcommenter'
Plug 'davidhalter/jedi-vim'
Plug 'https://github.com/ap/vim-css-color'
" Plug 'https://github.com/vim-airline/vim-airline'
" Plug 'nvim-lualine/lualine.nvim'

Plug 'https://github.com/hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

"Plug 'https://github.com/preservim/nerdtree'
"disabled nerdtree, using nvim-tree now
"
Plug 'https://github.com/windwp/windline.nvim'
Plug 'https://github.com/raimondi/delimitmate'
"Plug 'https://github.com/maxmellon/vim-jsx-pretty'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/simrat39/rust-tools.nvim'

Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

Plug 'mlaursen/vim-react-snippets'
Plug 'neoclide/coc-prettier'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'dikiaap/minimalist'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'romgrk/barbar.nvim'
"Plug 'nvim-lualine/lualine.nvim'

" set find and replace configs
Plug 'nvim-pack/nvim-spectre'

call plug#end()

" run TSUpdate to upgrade treesiter 
"disabled nerdtree for now, using nvim-tree

"nnoremap <C-f> :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>

noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

"Open Nvim Tree in Vertical split mode
noremap <C-v> :NvimTreeOpen<CR>

"Opent terminal in horizontal split mode
noremap <C-t> :TerminalSplit bash<CR>

":colorscheme jellybeans
" colo seoul256
colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

"set t_Co=256
"syntax on
"colorscheme minimalist

let g:airline_powerline_fonts = 1

nmap <C-b> :TagbarToggle<CR>

let g:vim_jsx_pretty_colorful_config = 1 " default 0

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"



":TerminalSplit bash -->Open terminal in Horizontally split mode
":TerminalVSplit bash --> Open terminal in Vertically split mode
":TerminalTab bash --> Open terminal in a fresh Tab


lua <<EOF
require('spectre').setup()
-- require('lualine').setup({options = { theme = 'powerline_dark' } })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },})
require('nvim-treesitter.configs').setup({
indent={
  enable=true
}
})

--require('wlsample.airline_anim')
--require('wlsample.airline_luffy')

require('windline').add_status(
  require('spectre.state_utils').status_line(),
  --require('wlsample.airline_luffy')
  require('wlsample.airline')

    )

--- Autocompletion setup
local cmp = require'cmp'

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    }, {{ name = 'buffer'}}),
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end 
    },
  window = {
    window = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered (),
    },
  mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-m>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
})


-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

-- Configure multiple language servers 
local servers = { 'bashls', 'pyright', 'lua_ls','tsserver' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

EOF

let g:rustfmt_autosave = 1
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = '--lib es6'

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif


