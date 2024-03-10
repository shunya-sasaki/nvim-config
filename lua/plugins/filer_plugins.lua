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
            -- vim.keymap.set('n', '<C-b>', "<cmd> Fern . -reveal=% -drawer -toggle <CR>")
            vim.keymap.set('n', '<C-b>', "<cmd> Fern . -drawer -toggle <CR>")

            local function extractExtension(filename)
                -- return an empty string if the file name starts with ".".
                if filename:sub(1, 1) == "." then
                    return ""
                else
                    -- extract the back from the ".".
                    return filename:match("^.+%.(.+)$") or ""
                end
            end

            local function compareExtensions(a, b)
                local extA = extractExtension(a)
                local extB = extractExtension(b)
                if extA > extB then
                    return 1
                elseif extA < extB then
                    return -1
                else
                    return 0
                end
            end

            local function compare(n1, n2)
                local name1 = n1.name
                local name2 = n2.name
                local is_dir1 = n1.status -- 0: file, 1: directory
                local is_dir2 = n2.status
                if (is_dir1 > is_dir2) then
                    return -1
                elseif (is_dir1 < is_dir2) then
                    return 1
                else
                    local extension_compare_result = compareExtensions(name1, name2)
                    if extension_compare_result ~= 0 then
                        return extension_compare_result
                    else
                        if (name1:sub(1, 1) == "." and name2:sub(1, 1) ~= ".") then
                            return -1
                        elseif (name1:sub(1, 1) ~= "." and name2:sub(1, 1) == ".") then
                            return 1
                        elseif name1 > name2 then
                            return -1
                        elseif name1 < name2 then
                            return 1
                        else
                            return 0
                        end
                    end
                end
            end

            local function compare_extension()
                return {
                    compare = compare
                }
            end
            vim.g['fern#comparators'] = {
                extension = compare_extension }
            vim.g['fern#comparator'] = "extension"
        end
    },
    {
        "lambdalisue/fern-renderer-nerdfont.vim",
        dependencies = { "lambdalisue/nerdfont.vim" },
    },
}
