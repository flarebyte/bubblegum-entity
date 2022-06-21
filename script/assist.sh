#!/bin/sh
npx baldrick-whisker@latest render --diff generated/attribute.json script/template/test-data.hbs tests/AttributeTestData.elm
npx baldrick-whisker@latest render --diff generated/outcome.json script/template/test-data.hbs tests/OutcomeTestData.elm
npx baldrick-whisker@latest render --diff generated/validation.json script/template/test-data.hbs tests/ValidationTestData.elm
