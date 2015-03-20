.PHONY: test

MODULE_DIR = ./node_modules
BIN_DIR = $(MODULE_DIR)/.bin
MOCHA_BIN = $(BIN_DIR)/mocha
TEST_UNIT_DIR = ./test
MOCHA_REPORTER = spec

install:
	npm install

clean:
	rm -rf ./node_modules

test: test-unit

test-unit:
	$(MOCHA_BIN) \
	--reporter $(MOCHA_REPORTER) \
	--compilers coffee:coffee-script/register \
	--colors $(TEST_UNIT_DIR)

cov-html:
	$(MOCHA_BIN) \
	--require coffee-coverage/register \
	--compilers coffee:coffee-script/register \
	-R html-cov --bail test/ > cov.html

coverall:
	YOURPACKAGE_COVERAGE=1 \
	$(MOCHA_BIN) \
	--require coffee-coverage/register \
	--compilers coffee:coffee-script/register \
	-R mocha-lcov-reporter | ./node_modules/coveralls/bin/coveralls.js
