local fio = require('fio')

local function read_file(path_to_file)
    local file, err = fio.open(path_to_file, {"O_RDONLY"})
    if err ~= nil then
        return nil, err
    end
    local data = file:read()
    file:close()

    return data
end

local function write_file(path_to_file, data)
    local file, err = fio.open(path_to_file, {"O_WRONLY"})
    if err ~= nil then
        return false, err
    end

    local ok = file:write(data)
    if not ok then
        return false, "Fail to write"
    end

    file:close()
    return true
end

return {
    read_file = read_file,
    write_file = write_file,
}
