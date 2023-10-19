require('gitblame').setup {
  enabled = false,
  date_format = '%c'
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<Leader>gb', ':GitBlameToggle<CR>', opts)
vim.keymap.set('n', '<Leader>gc', ':GitBlameCopyCommitURL<CR>', opts)
