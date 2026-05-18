local languages = require("core.util").get_language_info()
local blink = require("blink.cmp")

blink.setup()

for _, info in pairs(languages) do
	vim.lsp.config(info.lsp, {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})

	vim.lsp.enable(info.lsp)
end

--so far we are only having lsp configurations for
--lua
--ruby
