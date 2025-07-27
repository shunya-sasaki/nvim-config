BufferTranslator = {}

-- Workflow for CodeCompanion to translate text to another language.
-- @param src_language string: Original langauge of the target text.
-- @param dist_language string: Target language.
function BufferTranslator.workflow(src_lang, dist_lang)
	return {
		strategy = "workflow",
		description = string.format("Translate %s text to %s with constraints", src_lang, dist_lang),
		opts = {
			modes = { "n" },
			stop_context_insertion = true,
		},
		prompts = {
			{
				{
					role = "system",
					content = string.format(
						[[
                    You are a senior engineer with expertise in translating Japanese to English.
                    You are given a %s text and you need to translate it to %s.
                ]],
						src_lang,
						dist_lang
					),
					opts = { auto_submit = true },
				},
				{
					role = "user",
					content = string.format(
						[[ Please translate the %s text in #{buffer} to %s." ]],
						src_lang,
						dist_lang
					),
					opts = { auto_submit = true },
				},
				{
					role = "user",
					content = [[
                @{full_stack_dev}
                Please modify the current file to replace the contents to the translated one.
        ]],
					opts = { auto_submit = true },
				},
			},
		},
	}
end

return BufferTranslator
