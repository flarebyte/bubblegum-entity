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
	sh script/build-ci.sh

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

diff:
	elm-package diff

generate:
	rm -rf generated
	npx baldrick-whisker@latest object generated/attribute.json src/Bubblegum/Entity/Attribute.elm script/data/attribute.json
	npx baldrick-whisker@latest render generated/attribute.json script/template/tests.hbs tests/AttributeTests2.elm
