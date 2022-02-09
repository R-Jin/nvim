local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("bottle.lsp.lsp-installer")
require("bottle.lsp.handlers").setup()
