# tnt-multipart-content
## Table of contents
* [General information](#general-information)
* [Installation](#installation)
* [Usage](#usage)
* [An example of using the module](#an-example-of-using-the-module)

## General information
Converter of parameters to request body type `multipart/form-data`

## Installation
You can:
* clone the repository:
``` shell
git clone https://github.com/a1div0/tnt-multipart-content.git
```
* install the `tnt-multipart-content` module using `tarantoolctl`:
```shell
tarantoolctl rocks install https://raw.githubusercontent.com/a1div0/tnt-multipart-content/main/tnt-multipart-content-scm-1.rockspec
```

## Usage
### Encode simple params
```lua
local multi = require('tnt-multipart-content')
local params = {
    aaa = 'too',
    [2] = 'foo',
    ccc = 3,
}

local body, options = multi.encode(params)
```

### Encode files
```lua
local file = read_file('./filename')
local params = {
    too = 'foo',
    circle_svg = {
        filename = 'filename',
        content_type = 'application/octet-stream',
        content_transfer_encoding = 'binary',
        data = file,
    },
}

local body, options = multi.encode(params)
```

## An example of using the module
```lua
local multi = require('tnt-multipart-content')
local http_client = require("http.client").new()

local params = {
    aaa = 'too',
    [2] = 'foo',
    ccc = 3,
}

-- Encode
local body, options = multi.encode(params)

-- Send
local response = http_client:post('https://url', body, options)
if response.status ~= 200 then
    error(response.reason)
end
```