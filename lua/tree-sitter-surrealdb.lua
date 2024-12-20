local function setup()
	vim.filetype.add({
		extension = {
			surql = "surql",
			surrealql = "surql",
		},
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.surrealdb = {
		install_info = {
			url = "https://github.com/Skyppex/tree-sitter-surrealdb.git",
			files = { "src/parser.c" },
			branch = "main",
		},
		filetype = "surql",
	}

	local highlights_scm = [[
	(keyword) @keyword
	(string) @string
	(number) @number
	(punctuation) @punctuation
	(operator) @operator
	(variable) @type
	(constant) @constant.builtin
	(function) @function
	(bool) @boolean
	(nothing) @type
	(comment) @comment
	(record) @type
	(function) @function
	(property) @field
	(identifier) @text.emphasis
	(casting) @conceal
	(duration) @number
	(type) @type
	(delimiter) @punctuation.delimiter
	]]

	local injections_scm = [[
	(scripting_content) @javascript
	]]

	local runtime_path = vim.fn.stdpath("cache")
	vim.opt.runtimepath:append(runtime_path)
	vim.fn.mkdir(runtime_path .. "/queries/surrealdb", "p")

	if vim.fn.isdirectory(runtime_path .. "/queries/surrealdb") == 1 then
		local highlights_file = io.open(runtime_path .. "/queries/surrealdb/highlights.scm", "w")
		io.output(highlights_file)
		io.write(highlights_scm)
		io.close(highlights_file)

		local injections_file = io.open(runtime_path .. "/queries/surrealdb/injections.scm", "w")
		io.output(injections_file)
		io.write(injections_scm)
		io.close(injections_file)
	end
end

return { setup = setup }
