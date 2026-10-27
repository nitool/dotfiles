local schema = 'org.gnome.desktop.interface'
local key = 'color-scheme'

if vim.fn.executable('gsettings') ~= 1 then
    return
end

local function to_background(value)
    return value:find('prefer%-dark') and 'dark' or 'light'
end

vim.o.background = to_background(vim.fn.system({ 'gsettings', 'get', schema, key }))

vim.fn.jobstart({ 'gsettings', 'monitor', schema, key }, {
    on_stdout = function(_, data)
        local line = table.concat(data, '')
        if line == '' then
            return
        end
        vim.schedule(function()
            vim.o.background = to_background(line)
        end)
    end,
})
