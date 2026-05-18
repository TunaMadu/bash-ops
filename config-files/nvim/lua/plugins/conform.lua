local util = require("core.util")
local conform = require("conform")

-- given a formatters and a file type
-- conform tries to format a filetype with a given formatter, if present

conform.setup({
	formatters_by_ft = util.get_language_formatters(),
	format_on_save = { -- elimates the need to make the autocommand conform can handle it under the hood
		timeout_ms = 500,
	},
})
