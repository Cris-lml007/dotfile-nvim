autocmd VimEnter * :LspStart
"------------------------------
"apagando coc
"let g:coc_start_at_startup = v:false
let b:coc_enabled=0

silent! nunmap <silent><expr> <TAB>
silent! nunmap <expr><S-TAB>

" Use <c-space> to trigger completion.
if has('nvim')
	silent! nunmap <silent><expr> <c-space>
else
  silent! nunmap <silent><expr> <c-@>
endif

silent! nunmap <silent><expr> <cr>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
silent! nunmap <silent> [g
silent! nunmap <silent> ]g

" GoTo code navigation.
silent! nunmap <silent> gd
silent! nunmap <silent> gy
silent! nunmap <silent> gi
silent! nunmap <silent> gr


if has('nvim')
  inoremap <silent><expr> <c-b> coc#refresh()
else
  inoremap <silent><expr> <c-b> coc#refresh()
endif

"------------------------------

set completeopt=menu,menuone,noselect
lua << END
--configuracion del diagnostico
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--instalador de lsp language
require("nvim-lsp-installer").setup({
automatic_installation = true,
ui = {
	icons = {
		server_installed = "✓",
		server_pending = "➜",
		server_uninstalled = "✗"
		}
	}
})


---------CONFIGURACION DE TECLAS DE AUTOCOMPLETADO, PARECIDO A COC.NVIM
local cmp = require'cmp'
local luasnip = require 'luasnip'

cmp.setup({
formatting = {
        format = function(_, vim_item)
            local icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = "",
                Table = " ",
                Object = "",
                Tag = " ",
                Array = " ",
                Boolean = "蘒",
                Number = "",
                String = "",
                Calendar = " ",
                Watch = "",
            }
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

            return vim_item
        end,
    },
snippet = {
	expand = function(args)
	vim.fn["vsnip#anonymous"](args.body)
	--require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	end,
	},
window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
	},
mapping = cmp.mapping.preset.insert({
	['<TAB>'] = cmp.mapping(function(fallback)
					if cmp.visible() then 
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						cmp.complete()
					end
				end
				),
	['<S-TAB>'] = cmp.mapping(function(fallback)
					if cmp.visible() then 
						cmp.select_prev_item()
					else
						cmp.complete()
					end
				end
				),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
	sources = cmp.config.sources({
	{ name = 'nvim_lsp' },{name = 'path'},
	{ name = 'vsnip' }, -- For vsnip users.
	--{ name = 'luasnip' }, -- For luasnip users.
	-- { name = 'ultisnips' }, -- For ultisnips users.
	-- { name = 'snippy' }, -- For snippy users.
	}, {
	{ name = 'buffer' },
	})
})

cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
	{ name = 'cmp_git' }, -- puede especificar la fuente `cmp git` si la instaló.
	}, {
	{ name = 'buffer' },
	})
})

-- use cmdline & path source para ':' (si activó el `menú nativo`, esto ya no funcionará).
--cmp.setup.cmdline(':', {
--	mapping = cmp.mapping.preset.cmdline(),
--	sources = cmp.config.sources({
--	{ name = 'path' }
--	},{
--	{name = 'buffer'}
--	},{
--	{name = 'nvim_lsp'}
--	},{
--	{name= 'nvim_lua'}
--	}, {
--	{ name = 'cmdline' }
--	})
--})
---------------------------------------------------------------------------------
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --  require('lspconfig')['csharp_ls'].setup {
  --	  capabilities = capabilities
  --	  }

--vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)

--MAPEOS
--mostrar documentacion
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--mostrar definicion
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--mostrar implementation
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--mostrar tipo de declaracion
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
--acciones de codigo/correcciones
vim.keymap.set('n', '<space>c', vim.lsp.buf.code_action, bufopts)
--referencias
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--renombrar variable
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)

require('dressing').setup({
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = true,

    -- Default prompt string
    default_prompt = "Input:",

    -- Can be 'left', 'right', or 'center'
    prompt_align = "left",

    -- When true, <Esc> will close the modal
    insert_only = true,

    -- When true, input will start in insert mode.
    start_in_insert = true,

    -- These are passed to nvim_open_win
    anchor = "SW",
    border = "rounded",
    -- 'editor' and 'win' will default to being centered
    relative = "cursor",

    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    width = nil,
    -- min_width and max_width can be a list of mixed types.
    -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },

    -- Window transparency (0-100)
    winblend = 10,
    -- Change default highlight groups (see :help winhl)
    winhighlight = "",

    -- Set to `false` to disable
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },

    override = function(conf)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,

    -- see :help dressing_get_config
    get_config = nil,
  }
})
END

"coleccion de snipers
let g:vsnip_filetypes.ruby = ['rails']
