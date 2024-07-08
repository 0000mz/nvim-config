
require("mason").setup()
require("mason-lspconfig").setup()

local lsp = require("lspconfig")
local coq = require("coq")

lsp.clangd.setup{}
lsp.clangd.setup(coq.lsp_ensure_capabilities{})

lsp.vtsls.setup{}
lsp.vtsls.setup(coq.lsp_ensure_capabilities{})

lsp.rust_analyzer.setup{}
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities{})

lsp.cmake.setup{}
lsp.cmake.setup(coq.lsp_ensure_capabilities{})

lsp.pylsp.setup{}
lsp.pylsp.setup(coq.lsp_ensure_capabilities{})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- Set autocommands conditional on server_capabilities
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.server_capabilities.documentHighlightProvider then
      vim.cmd [[
      hi! LspReferenceRead cterm=bold gui=bold ctermbg=237 guibg=#343d46
      hi! LspReferenceText cterm=bold gui=bold ctermbg=237 guibg=#343d46
      hi! LspReferenceWrite cterm=bold gui=bold ctermbg=237 guibg=#343d46
      ]]
      vim.api.nvim_create_augroup('lsp_document_highlight', {
        clear = false
      })
      vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = 'lsp_document_highlight',
      })
      -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      --   group = 'lsp_document_highlight',
      --   buffer = bufnr,
      --   callback = vim.lsp.buf.document_highlight,
      -- })
      -- vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      --   group = 'lsp_document_highlight',
      --   buffer = bufnr,
      --   callback = vim.lsp.buf.clear_references,
      -- })
    end
  end,
})
