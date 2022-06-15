.PHONY: html js test doc

SRC = src

reset:
	rm -rf elm-stuff
	rm -rf tests/elm-stuff

install-global:
	yarn global add elm-format@0.8.4
	yarn global add elm-review
	yarn global add elm-upgrade
	yarn global add elm-doc-preview
	yarn global add elm-analyse

build: test beautify doc

build-ci:
	sh scripts/build-ci.sh

install:
	elm install -y
	pushd tests && elm install -y && popd

test:
	elm-test

beautify:
	elm-format src/ --yes
	elm-format tests/ --yes

doc:
	elm make --docs=documentation.json

preview-doc:
	elm-doc-preview

analyze:
	elm-analyse -s -o

generate:
	cd scripts && python -B generate_tests.py

parse:
	python scripts/parse_elm.py

diff:
	elm-package diff

gen:
	cd generator; node --loader ts-node/esm src/generator.ts
	elm-format tests/ --yes