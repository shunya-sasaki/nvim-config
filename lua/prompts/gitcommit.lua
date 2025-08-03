GitCommit = {}

function GitCommit.prompts()
	return {
		strategy = "inline",
		description = "Create git commit message.",
		opts = {
			modes = { "n", "v", "i" },
			stop_context_insertion = true,
			is_slash_cmd = true,
			short_name = "gcm",
			auto_submit = true,
			placement = "add",
			ignore_system_prompt = true,
		},
		prompts = {
			{
				role = "system",
				content = function()
					vim.g.codecompanion_auto_tool_mode = true
					return [[
You are an expert at following the Conventional Commit specification.
Create a commit message based on the output of git diff.

The commit message must be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

`type` must be one of the following:

- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- docs: Documentation only changes
- feat: A new feature
- fix: A bug fix
- perf: A code change that improves performance
- refactor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- test: Adding missing tests or correcting existing tests
          ]]
				end,
				opts = { auto_submit = true },
			},
			{
				role = "user",
				content = [[
@{cmd_runner} run `git diff --cached` to get the output of git diff,
and create git commit message from staged changes.
          ]],
				opts = { auto_submit = true, stop_context_insertion = true, requires_approval = false },
			},
			{
				role = "user",
				content = [[
Check the git commit message is following with the Conventional Commit format.
If it is not, rewrite the commit message to follow the format.
          ]],
				opts = { auto_submit = true, stop_context_insertion = true, requires_approval = false },
			},
			{
				role = "user",
				content = [[
Insert the message at the top of the current #{buffer} using @{insert_edit_into_file}.
          ]],
				opts = {
					auto_submit = true,
					stop_context_insertion = true,
					requires_approval = { buffer = true, file = false },
					user_confirmation = false,
				},
			},
		},
	}
end

local git_op_table = {
	["Create git commit message"] = GitCommit.prompts(),
}

return git_op_table
