--- Rreturn extension of a file name.
-- If the file name starts with ".", return an empty string.
-- @param filename string
-- @return string that indicates the extension of the file
local function extract_extension(filename)
    -- return an empty string if the file name starts with ".".
    if filename:sub(1, 1) == "." then
        return ""
    else
        -- extract the back from the ".".
        return filename:match("^.+%.(.+)$") or ""
    end
end

--- Compare two file or directory pathes by their names.
-- If n1 has a larger name than n2, return 1
-- that means n1 is displayed after n2.
-- @param n1 first file or directory
-- @param n2 second file or directory
-- @return a int value that indicates the order of the two pathes
local function compare_name(n1, n2)
    if n1.name > n2.name then
        return 1
    elseif n1.name < n2.name then
        return -1
    else
        return 0
    end
end

--- Compare two file names by their extensions.
-- If the file name starts with ".",
-- it is considered to have no extension.
-- If n1 has a larger extension than n2, return 1
-- that means n1 is displayed after n2.
-- @param n1 first file or directory
-- @param n2 second file or directory
-- @return a int value that indicates the order of the two pathes
local function compare_extension(n1, n2)
    local ext1 = extract_extension(n1.name)
    local ext2 = extract_extension(n2.name)
    if ext1 > ext2 then
        return 1
    elseif ext1 < ext2 then
        return -1
    else
        return compare_name(n1, n2)
    end
end

--- Compare two file or directory pathes by their status.
-- The status is that the path is a directory or not,
-- if the path is a file, the status is 0.
-- And if the path is a closed directory, the status is 1.
-- Otherwise, the path is an opened directory,
-- the status is 2.
-- @param n1 first file or directory
-- @param n2 second file or directory
-- @return a int value that indicates the order of the two pathes
local function compare_status(n1, n2)
    if n1.status > n2.status then
        return -1
    elseif n1.status < n2.status then
        return 1
    else
        return compare_extension(n1, n2)
    end
end

--- Compare two file or directory pathes by their key value.
-- The key value is a parent directory name of the path.
-- @param n1 first file or directory
-- @param n2 second file or directory
-- @param i_class the number of levels from the root directory
-- @return a int value that indicates the order of the two pathes
local function compare_keyvalue(n1, n2, i_class)
    local val1 = n1.__key[i_class]
    local val2 = n2.__key[i_class]
    if val1 > val2 then
        return -1
    elseif val1 < val2 then
        return 1
    else
        return 0
    end
end

--- Compare two file or directory pathes.
-- If the pathes have the same key value, compare their status.
-- Otherwise, compare their key value.
-- @param n1 first file or directory
-- @param n2 second file or directory
-- @param i_class the number of levels from the root directory
-- @return a int value that indicates the order of the two pathes
local function compare_path(n1, n2, i_class)
    if #n1.__key == 0 or #n2.__key == 0 or
        #n1.__key == i_class and #n2.__key == i_class then
        return compare_status(n1, n2)
    else
        return compare_keyvalue(n1, n2, i_class)
    end
end

--- Compare two file or directory pathes by their extensions.
-- @param n1 first file or directory
-- @param n2 second file or directory
-- @return a int value that indicates the order of the two pathes
local function compare(n1, n2)
    local n_n1 = #n1.__key
    local n_n2 = #n2.__key
    local n_loop = math.max(n_n1, n_n2)
    for i = 1, n_loop do
        local result = compare_path(n1, n2, i)
        if result ~= 0 then
            return result
        end
    end
end

--- Return a comparator that compares two pathes by their extensions.
local function extension_comparator()
    return {
        compare = compare
    }
end

return {
    {
        'lambdalisue/fern.vim',
        priority = 1000,
        config = function()
            if Config.with_nf == true then
                vim.g["fern#renderer"] = "nerdfont"
            else
                vim.g["fern#renderer"] = "default"
            end
            vim.g["fern#default_hidden"] = 1
            vim.keymap.set('n', '<C-b>', "<cmd> Fern . -drawer -toggle <CR>")

            vim.g['fern#comparators'] = {
                extension = extension_comparator }
            vim.g['fern#comparator'] = "extension"
        end
    },
    {
        "lambdalisue/fern-renderer-nerdfont.vim",
        dependencies = { "lambdalisue/nerdfont.vim" },
    },
}
