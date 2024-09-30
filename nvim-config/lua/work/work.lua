local M = {}
local context = {}

-- Funkcja zapisująca czas uruchomienia i katalog
M.start_work = function ()
    context.start_time = os.date("%Y-%m-%d %H:%M:%S")
    context.project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

-- Funkcja zapisująca czas zamknięcia
M.stop_work = function ()
    local end_time = os.date("%Y-%m-%d %H:%M:%S")
    if context.start_time == nil then
        print("Nie rozpoczęto pracy")
        return
    end

    local file = io.open(os.getenv("HOME") .. "/timesheet.csv", "a")
    if file == nil then
        print("Nie można otworzyć pliku timesheet.csv")
        return
    end

    file:write(context.project .. "," .. context.start_time .. "," .. end_time .. "\n")
    file:close()
end

return M
