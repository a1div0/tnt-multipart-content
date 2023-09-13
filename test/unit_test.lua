local t = require('luatest')
local g = t.group()

local multi = require('tnt-multipart-content')
local helper = require('test.helper')
local digest = require('digest')

--require('lua-debug-helper').run()

g.test_encode_simple_params = function()
    local params = {
        aaa = 'too',
        [2] = 'foo',
        ccc = 3,
    }

    local body = multi.encode(params)

    local body_must_be_b64 = helper.read_file('./test/content/simple-params.txt')
    local body_must_be = digest.base64_decode(body_must_be_b64)
    t.assert_equals(body, body_must_be)
end

g.test_zero_params = function()
    local body, _, delimiter = multi.encode({})
    local body_must_be = ('--%s--\r\n'):format(delimiter)
    t.assert_equals(body, body_must_be)
end

g.test_options = function()
    local _, options, delimiter = multi.encode({})
    local options_must_be = {
        headers = {
            ["Content-Type"] = "multipart/form-data; charset=utf-8; boundary=" .. delimiter,
        },
    }
    t.assert_equals(options, options_must_be)
end

g.test_files = function()
    local circle_svg = helper.read_file('./test/content/circle.svg')
    local cat_gif = helper.read_file('./test/content/cat.gif')
    local params = {
        too = 'foo',
        circle_svg = {
            filename = 'circle.svg',
            content_type = 'application/octet-stream',
            content_transfer_encoding = 'binary',
            data = circle_svg,
        },
        cat_gif = {
            filename = 'cat.gif',
            content_type = 'application/octet-stream',
            content_transfer_encoding = 'binary',
            data = cat_gif,
        },
    }

    local body = multi.encode(params)

    local body_must_be_b64 = helper.read_file('./test/content/file-params.txt')
    local body_must_be = digest.base64_decode(body_must_be_b64)
    t.assert_equals(body, body_must_be)
end
