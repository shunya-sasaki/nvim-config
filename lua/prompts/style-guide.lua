local StyleGuide = {}

function StyleGuide.prompts(style_guide_name, web_url, short_name)
	return {
		strategy = "chat",
		description = string.format(
			[[
      Add %s to the context.
      ]],
			style_guide_name
		),
		opts = { is_default = true, auto_submit = true, is_slash_cmd = true, short_name = short_name },
		context = {
			{
				type = "url",
				url = web_url,
			},
		},
		prompts = {
			{
				role = "system",
				content = [[
        You are a senior engineer with deep expertise in programming style guides.
        Answer questions about coding style in strict accordance with the Google Style Guide,
        and provide concrete, actionable recommendations to improve code quality.
        ]],
				opts = {
					is_default = true,
					auto_submit = true,
				},
			},
			{
				role = "user",
				content = string.format(
					[[
        I want you help me to improve my code quality.
        Colud you answer my question about programming style in accordance with %s?
        ]],
					style_guide_name
				),
				opts = {
					is_default = true,
					auto_submit = true,
				},
			},
		},
	}
end

local prompts_table = {
	["Google C++ Style Guide"] = StyleGuide.prompts(
		"Google C++ Style Guide",
		"https://google.github.io/styleguide/cppguide.html",
		"google-cpp"
	),
	["Google JSON Style Guide"] = StyleGuide.prompts(
		"Google JSON Style Guide",
		"https://google.github.io/styleguide/jsoncstyleguide.xml",
		"google-json"
	),
	["Google HTML/CSS Style Guide"] = StyleGuide.prompts(
		"Google HTML/CSS Style Guide",
		"https://google.github.io/styleguide/htmlcssguide.html",
		"google-html-css"
	),
	["Google Markdown Style Guide"] = StyleGuide.prompts(
		"Google Markdown Style Guide",
		"https://google.github.io/styleguide/docguide/style.html",
		"google-markdown"
	),

	["Google Python Style Guide"] = StyleGuide.prompts(
		"Google Python Style Guide",
		"https://google.github.io/styleguide/pyguide.html",
		"google-python"
	),
	["Google Shell Style Guide"] = StyleGuide.prompts(
		"Google Shell Style Guide",
		"https://google.github.io/styleguide/shellguide.html",
		"google-shell"
	),
	["Google TypeScript Style Guide"] = StyleGuide.prompts(
		"Google TypeScript Style Guide",
		"https://google.github.io/styleguide/tsguide.html",
		"google-ts"
	),
}

return prompts_table
