local M = {}

-- :lua= vim.bo.filetype
--
-- The filetype determines the language used.
-- filetypes =kinda_equals= language
local filetype_info = {
	lua = {
		lsp = "lua_ls",
		formatters = { "stylua" },
	},

	-- ruby is a weird one
	-- the only thing i was able to find surrounding ruby-lsp vs solargraph was:
	-- one is newer, ruby-lsp requires a gemfile whereas solargraph
	-- can use globally installed gems.
	-- Solargraph is the more automatic since it requires less setup. but the errors
	-- aren't as nice IMO either way, both use rubocop under the hood for
	-- formatting and linting within the lsp itself... p freaking cool
	ruby = {
		lsp = "ruby_lsp",
		formatters = { lsp_format = "prefer" },
		-- linters = { "" }, -- we don't even need this line here since it will try linting with rubocop if given a config
	},
}

M.get_language_info = function()
	return filetype_info
end

M.get_language_formatters = function()
	local temp = {}

	for lang, info in pairs(filetype_info) do
		temp[lang] = info.formatters
	end

	return temp
end

M.get_language_linters = function()
	local temp = {}

	for lang, info in pairs(filetype_info) do
		if info.linters ~= nil then
			temp[lang] = info.linters
		end
	end

	return temp
end

M.fetch_plugins = function(sources)
	local gh = "https://github.com/"

	local plugins = {}

	for _, src in pairs(sources) do
		if type(src) == "string" then
			table.insert(plugins, gh .. src)
		else
			table.insert(plugins, { src = gh .. src[1], version = src[2] })
		end
	end

	vim.pack.add(plugins)
end

M.load_plugins = function()
	local files = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugins")

	for i = 1, #files do
		local plugin_name = vim.split(files[i], "%.")[1]
		require("plugins." .. plugin_name)
	end
end

return M
