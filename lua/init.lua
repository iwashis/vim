require("plugins")
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

