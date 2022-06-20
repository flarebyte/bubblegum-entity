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
	npx baldrick-whisker@latest object generated/outcome.json src/Bubblegum/Entity/Outcome.elm script/data/outcome.json
	npx baldrick-whisker@latest object generated/validation.json src/Bubblegum/Entity/Validation.elm script/data/validation.json
	npx baldrick-whisker@latest render generated/attribute.json script/template/tests.hbs tests/AttributeTests.elm
	npx baldrick-whisker@latest render generated/outcome.json script/template/tests.hbs tests/OutcomeTests.elm
	npx baldrick-whisker@latest render generated/validation.json script/template/tests.hbs tests/ValidationTests.elm
	elm-format tests/AttributeTests.elm --yes
	make test

assist:
	npx baldrick-whisker@latest render --diff generated/attribute.json script/template/test-data.hbs tests/AttributeTestData.elm


