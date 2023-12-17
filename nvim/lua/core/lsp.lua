require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
require'lspconfig'.svlangserver.setup{
    flags = lsp_flags,
}
require'lspconfig'.tsserver.setup{
    flags = lsp_flags,
}
require'lspconfig'.eslint.setup{
    flags = lsp_flags,
}
require'lspconfig'.clangd.setup{
    flags = lsp_flags,
}
require'lspconfig'.clojure_lsp.setup{}

-- nvm-cmp
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'eslint', 'clojure_lsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-l>'] = cmp.mapping(function(fallback)
      local copilot_keys = vim.fn["copilot#Accept"]()
      if copilot_keys ~= "" then
          vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
          fallback()
      end
    end, { 'i', 's'}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
			--	fallback()
			-- else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
-- Lsp mapping
local map = vim.api.nvim_set_keymap

map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {})
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", {})
map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", {})
map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", {})
map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {})
map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
map("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", {})

vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
