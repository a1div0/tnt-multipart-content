package = "tnt-multipart-content"
version = "scm-1"
source = {
    url    = 'git+https://github.com/a1div0/tnt-multipart-content.git',
    branch = "main",
}

description = {
    summary = "Converter of parameters to request body type `multipart/form-data`",
    homepage = "https://github.com/a1div0/tnt-multipart-content",
    license = "The Unlicense",
}

dependencies = {
    "lua >= 5.1",
    "checks",
}

build = {
    type = 'builtin';
    modules = {
        ['tnt-multipart-content'] = 'tnt-multipart-content/init.lua';
    }
}
