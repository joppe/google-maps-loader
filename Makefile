SHELL := /bin/bash

PWD := $(shell pwd)
KARMA_BIN := node_modules/karma/bin/karma
KARMA_CONFIG := $(PWD)/test/karma.conf.js

npm:
	@echo "Install node packages"
	npm install

bower:
	@echo "Install bower packages"
	bower install

babel:
	@echo "Transpile javascript"
	$(PWD)/node_modules/babel/bin/babel.js src --stage 1 --out-dir dist --modules system

babel-demo:
	@echo "Transpile demo javascript"
	$(PWD)/node_modules/babel/bin/babel.js demo/src --stage 1 --out-dir demo/js --modules system

babel-watch:
	@echo "Transpile javascript (watch)"
	$(PWD)/node_modules/babel/bin/babel.js src --stage 1 --out-dir dist --modules system --watch

babel-watch-demo:
	@echo "Transpile demo javascript (watch)"
	$(PWD)/node_modules/babel/bin/babel.js demo/src --stage 1 --out-dir demo/js --modules system --watch

karma_test:
	@echo "Start karma test"
	@node $(KARMA_BIN) start $(KARMA_CONFIG) --single-run --no-auto-watch --reporters dots

bundle:
	@echo "Bundle the javascript"
	@node ./bundle.js

setup: npm bower babel babel-demo bundle

clean:
	@echo "Cleanup installed files"
	@cd dist && ls | grep -v .gitkeep | xargs rm -rf
	@rm -rf node_modules
