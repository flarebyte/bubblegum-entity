.PHONY: html js test doc

SRC = src

reset:
	rm -rf elm-stuff
	rm -rf tests/elm-stuff

build: test beautify doc

build-ci:
	sh scripts/build-ci.sh

install:
	elm-package install -y
	pushd tests && elm-package install -y && popd

test:
	elm-test

beautify:
	elm-format src/ --yes

doc:
	elm-make --docs=documentation.json

generate:
	cd scripts && python generate_attribute_tests.py

parse:
	python scripts/parse_elm.py

diff:
	elm-package diff
