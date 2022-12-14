"***************************PLUGINS**********************************
"cargar plugins de vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
"------PLUGINS VUNDLE----------
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on    " required
"------PLUGINS PACKER----------
lua << EOF
	require('packer').startup(function()
		use { "nvim-telescope/telescope-file-browser.nvim" }
		use 'nvim-telescope/telescope-project.nvim'
		use 'wbthomason/packer.nvim'
		---optimizador lua
		use 'lewis6991/impatient.nvim'
		--Pantalla de inicio
		use {
			"startup-nvim/startup.nvim",
			requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
			config = function()
			require"startup".setup()
			end
		}
		use {
		  'chipsenkbeil/distant.nvim',
		  config = function()
			require('distant').setup {
			  -- Applies Chip's personal settings to every machine you connect to
			  --
			  -- 1. Ensures that distant servers terminate with no connections
			  -- 2. Provides navigation bindings for remote directories
			  -- 3. Provides keybinding to jump into a remote file's parent directory
			  ['*'] = require('distant.settings').chip_default()
			}
		  end
		}
		--previsualizar markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = function() vim.fn["mkdp#util#install"]() end,
		})
		use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
		--cambiar variable
	end)
	require"startup".setup({theme = "dashboard"})
EOF
"------PLUGINS vim-plug--------
call plug#begin('~/.local/share/nvim/plugged')
"Temas
Plug 'morhetz/gruvbox'
Plug 'marko-cerovac/material.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

"guias de identacion
Plug 'lukas-reineke/indent-blankline.nvim'
"barra de estado
Plug 'nvim-lualine/lualine.nvim'
"iconos dev-icons
Plug 'kyazdani42/nvim-web-devicons'
"complemento para guardar archivos con sudo
Plug 'lambdalisue/suda.vim'
"coc-vim autocompletado
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"administrador buffer
Plug 'akinsho/bufferline.nvim', { 'tag': 'V2.*' }
"Iconos para los archivos y carpetas
Plug 'ryanoasis/vim-devicons'
"Plugin cerrado de parentesis
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
"plugin mini-mapa
Plug 'wfxr/minimap.vim'
"plugin de visualizaci??n de edicion html, css
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
"Plugin que muestra propiedades de una function
Plug 'majutsushi/tagbar'
"Plug 'stevearc/aerial.nvim'
"arbol de movimientos
Plug 'mbbill/undotree'
"colores hexadesimales
Plug 'chrisbra/colorizer'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" buscador de palabras
Plug 'easymotion/vim-easymotion'
"exlorador de archivos modo arbol
Plug 'scrooloose/nerdtree'
"complemento de tmux para la navegacion entre paneles
Plug 'christoomey/vim-tmux-navigator'
"Plugin para sacar caracteres especiales
Plug 'chrisbra/unicode.vim'
"closedtag html
Plug 'alvan/vim-closetag'
Plug 'andrewradev/tagalong.vim'
"traductor
Plug 'voldikss/vim-translator'
"paleta de colores
Plug 'KabbAmine/vCoolor.vim'
"telescopio
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"plugin sintaxis para nerdtree
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
"captura de codigo
Plug 'segeljakt/vim-silicon'
"flotar ventanas
Plug 'voldikss/vim-floaterm'
"Mejor identado treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
"sintaxis
"Plug 'scrooloose/syntastic'
"mostrar marcas
Plug 'kshenoy/vim-signature'
"Plug 'chentoast/marks.nvim'
"depurador
Plug 'puremourning/vimspector'
"iconos de colores
"Plug 'lambdalisue/nerdfont.vim'
"Plug 'lambdalisue/fern-renderer-nerdfont.vim'
"Plug 'lambdalisue/glyph-palette.vim'
"multiples cursores
"Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"tranparencia a los temas
Plug 'xiyaowong/nvim-transparent'
"gestor de proyectos
Plug 'ahmedkhalf/project.nvim'
"-----------LSP----------------
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
"autocompletado
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
"engine snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"dise??ador ui
Plug 'stevearc/dressing.nvim'
"-----------------------------
"coleccion de snippet
Plug 'rafamadriz/friendly-snippets'
"snippet unity
Plug 'kleber-swf/vscode-unity-code-snippets'
"-----------------------------
"probador de casos
Plug 'Cris-lml007/test.vim'
"manager database
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'tpope/vim-dadbod'
"nomodoro
Plug 'dbinagi/nomodoro'
"autocompletado para c#
"Plug 'OmniSharp/omnisharp-vim'
""Plug 'dense-analysis/ale'
call plug#end()
"------------Plugins config-----------------------

""" configuraci??n traductor
let g:translator_target_lang="ES"
let g:translator_default_engines=['google']
let NERDTreeQuitOnOpen = 1
"color de terminal flotante
"hi Floaterm guifg=red guibg=cian
"hi FloatermBorder guifg=white guibg=red
"poner un punto si un archivo no esta guardado
let g:lightline#bufferline#modified = ' ???'
"color de fondo de Markdown-Preview
let g:mkdp_theme = 'dark'
"bracey-connexion de varios equipos
let g:bracey_server_allow_remote_connections = 1

"iconos para dadbod
let g:db_ui_icons = {
			\ 'expanded': {
		 	\   'db': '??? ???',
		 	\   'buffers': '??? ???',
		 	\   'saved_queries': '??? ???',
		 	\   'schemas': '??? ???',
		 	\   'schema': '??? ???',
		 	\   'tables': '??? ???',
		 	\   'table': '??? ???',
		 	\ },
		 	\ 'collapsed': {
		 	\   'db': '??? ???',
		 	\   'buffers': '??? ???',
		 	\   'saved_queries': '??? ???',
		 	\   'schemas': '??? ???',
		 	\   'schema': '??? ???',
		 	\   'tables': '??? ???',
		 	\   'table': '??? ???',
		 	\ },
		 	\ 'saved_query': '???',
		 	\ 'new_query': '???',
		 	\ 'tables': '???',
		 	\ 'buffers': '???',
		 	\ 'add_connection': '???',
		 	\ 'connection_ok': '???',
		 	\ 'connection_error': '???',
			\}
"configuracion de complementos lua
lua << END
require('impatient')

config = function()
    vim.g.startup_disable_on_startup = true
    require("startup").setup(require("configs.startup_nvim"))
end

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true 
	},
  },
}
require("telescope").load_extension "file_browser"
require'telescope'.load_extension('project')
--require("aerial").setup({})
require('telescope').load_extension('projects')
require("project_nvim").setup{}
--configuracion de nomodoro
require('nomodoro').setup({
    work_time = 25,
    break_time = 5,
    menu_available = true,
    texts = {
        on_break_complete = "TIME WORK!",
        on_work_complete = "TAKE A BREAK!",
        status_icon = "???",
        timer_format = '!%0M:%0S' -- To include hours: '!%0H:%0M:%0S'
    },
    on_work_complete = function() end,
    on_break_complete = function() end
})
local lualine = require'lualine'
lualine.setup({
    sections = {
        lualine_x = {
			require('nomodoro').status,
			'encoding', 'fileformat', 'filetype'
        }
    }
})
END
"******************************************************************+
