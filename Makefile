SHELL := /bin/bash

.PHONY: clean test

.rocks:
	set -e
	tarantoolctl rocks install luacheck
	tarantoolctl rocks install luacov 0.13.0
	tarantoolctl rocks install luacov-reporters 0.1.0
	tarantoolctl rocks install luatest
	tarantoolctl rocks install https://raw.githubusercontent.com/a1div0/lua-debug-helper/main/lua-debug-helper-1.0.2-1.rockspec
	tarantoolctl rocks make tnt-multipart-content-scm-1.rockspec

clean:
	rm -rf ./.rocks luacov.*.out

test: .rocks
	./.rocks/bin/luacheck tnt-multipart-content/ test/ && \
	./.rocks/bin/luatest -v --coverage && \
    ./.rocks/bin/luacov -r summary && cat luacov.report.out
