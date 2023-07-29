require("plugins")
require("opts")
-- For basic settings like syntax, filetype and colorscheme:
vim.cmd [[
  syntax on
  filetype on
  filetype plugin indent on
  colorscheme onedark
]]

-- Setting the global variables:
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g.airline_theme = 'dark'
vim.g.airline_powerline_fonts = 1

-- Key mappings:
vim.api.nvim_set_keymap('n', '<C-a>', ':bn!<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<M-Left>', ':bp!<CR>', {noremap = true}) -- Uncomment if you want to use it
vim.api.nvim_set_keymap('n', '<C-z>', ':NERDTreeToggle <CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<M-Down>', ':NERDTreeFocus <CR>', {noremap = true}) -- Uncomment if you want to use it
-- Set options:
vim.wo.number = true
vim.o.showmode = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.bo.smartindent = true
vim.bo.autoindent = true
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.o.background = 'dark'
vim.o.laststatus = 0
vim.o.cmdheight = 4
vim.wo.relativenumber = true
vim.o.mouse = 'n'
-- vim.o.guifont = 'ProggyCleanTTSZBP:h12:cDEFAULT' -- Uncomment if you want to use it

vim.g.NERDTreeFileExtensionHighlightFullName = 1
vim.g.NERDTreeExactMatchHighlightFullName = 1
vim.g.NERDTreePatternMatchHighlightFullName = 1

-- Add the fzf path to the runtime path:
vim.opt.rtp:append('/opt/homebrew/bin/fzf')

-- Highlights:
vim.cmd 'highlight Comment cterm=italic gui=italic'
-- vim.cmd 'colo darkblue' -- Uncomment if you want to use it
-- vim.cmd 'hi Keyword ctermfg=darkcyan' -- Uncomment if you want to use it
-- vim.cmd 'hi Constant ctermfg=5*' -- Uncomment if you want to use it
-- vim.cmd 'hi Comment ctermfg=2*' -- Uncomment if you want to use it
-- vim.cmd 'hi Normal ctermbg=none' -- Uncomment if you want to use it
-- vim.cmd 'hi LineNr ctermfg=darkgrey' -- Uncomment if you want to use it
-- vim.g.onedark_italics=1 -- Uncomment if you want to use it
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    work = "~/Documents/org/work",
                    home = "~/Documents/org/home",
                    journal = "~/Documents/org/journal",
                }
            }
        }
    }
}
