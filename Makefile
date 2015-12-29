SHELL := /bin/bash

PWD := $(shell pwd)

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

bundle:
	@echo "Bundle the javascript"
	@node ./bundle.js

setup: npm bower babel babel-demo bundle

clean:
	@echo "Cleanup installed files"
	@cd dist && ls | grep -v .gitkeep | xargs rm -rf
