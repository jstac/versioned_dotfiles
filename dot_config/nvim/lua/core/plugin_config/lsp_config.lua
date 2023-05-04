
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"texlab"},
})

require("lspconfig").texlab.setup {}


