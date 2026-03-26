dist/index.js: index.js
	# we externalize the Actions toolkit deps because otherwise
	# ncc chokes on their imports
	./node_modules/.bin/ncc build index.js -o dist \
		-e @actions/github -e @actions/core
