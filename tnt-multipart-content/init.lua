local checks = require("checks")

local BOUNDARY_DELIMITER = "ggCKgaOO4iP6rVi8K5Fm3qaW"

local function encode(params)
    checks('table')

    local header_template = "--%s\r\nContent-disposition: form-data; name=\"%s\""
    local body_items = {}
    for key, value in pairs(params) do
        local body_header = header_template:format(BOUNDARY_DELIMITER, tostring(key))
        table.insert(body_items, body_header)
        if type(value) == "table" then
            if value.filename then
                local part = ("; filename=\"%s\""):format(value.filename)
                table.insert(body_items, part)
            end
            if value.content_type or value.mimetype then
                --local content_type = value.content_type or value.mimetype or "application/octet-stream"
                local part = ("\r\ncontent-type: %s"):format(value.content_type or value.mimetype)
                table.insert(body_items, part)
            end
            if value.content_transfer_encoding then
                local part = ("\r\ncontent-transfer-encoding: %s"):format(value.content_transfer_encoding)
                table.insert(body_items, part)
            end
            table.insert(body_items, "\r\n\r\n")
            table.insert(body_items, value.data)
        else
            table.insert(body_items, "\r\n\r\n")
            table.insert(body_items, value)
        end

        table.insert(body_items, "\r\n")
    end
    local body_end = ("--%s--\r\n"):format(BOUNDARY_DELIMITER)
    table.insert(body_items, body_end)
    local body = table.concat(body_items)

    local options = {
        headers = {
            ["Content-Type"] = "multipart/form-data; charset=utf-8; boundary=" .. BOUNDARY_DELIMITER,
        },
    }

    return body, options, BOUNDARY_DELIMITER
end

return {
    encode = encode,
}
