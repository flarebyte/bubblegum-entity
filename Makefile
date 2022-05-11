.PHONY: html js test doc

SRC = src

reset:
	rm -rf elm-stuff
	rm -rf tests/elm-stuff

install-global:
	yarn global add elm-format@0.8.4
	yarn global add elm-review
	yarn global add elm-upgrade

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
	elm make --docs=documentation.json

generate:
	cd scripts && python -B generate_tests.py

parse:
	python scripts/parse_elm.py

diff:
	elm-package diff
