POLVO = ./node_modules/.bin/polvo

watch:
	$(POLVO) -ws

release:
	$(POLVO) -rs

setup:
	npm install