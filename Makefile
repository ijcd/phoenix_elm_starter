.phony: build server

build:
	mix deps.get
	mix compile
	(cd apps/web ; npm install)
	(cd apps/web/web/elm ; elm package install -y)

server:
	mix phoenix.server
