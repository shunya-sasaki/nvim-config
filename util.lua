local function get_os_name()
    local wsl = os.getenv("WSLENV")
    if wsl then
        return "wsl"
    else
        local handle = io.popen("uname")
        local uname = nil
        if handle then
            uname = handle:read("*a"):gsub("^%s*(.-)%s*$", "%1")
        end

        if uname == "Linux" then
            return "linux"
        elseif uname == "Darwin" then
            return "macos"
        else
            return "unknown"
        end
    end
end

return {
    get_os_name = get_os_name
}
