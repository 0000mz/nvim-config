
require("mason").setup()
require("mason-lspconfig").setup()

local lsp = require("lspconfig")
local coq = require("coq")

lsp.clangd.setup{}
lsp.clangd.setup(coq.lsp_ensure_capabilities{})

lsp.vtsls.setup{}
lsp.vtsls.setup(coq.lsp_ensure_capabilities{})

