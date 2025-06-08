local function get_os_name()
	if vim.fn.has("mac") == 1 then
		return "mac"
	elseif vim.fn.has("linux") == 1 then
		return "linux"
	elseif vim.fn.has("unix") == 1 then
		return "unix"
	elseif vim.fn.has("sun") == 1 then
		return "sun"
	elseif vim.fn.has("bsd") == 1 then
		return "bsd"
	elseif vim.fn.has("win32") == 1 then
		return "win32"
	elseif vim.fn.has("win64") == 1 then
		return "win64"
	elseif vim.fn.has("wsl") == 1 then
		return "wsl"
	end
end

return {
	get_os_name = get_os_name,
}
