#!/bin/sh
echo "Generating assistance for Attribute ..."
npx baldrick-whisker@latest render --diff generated/attribute.json script/template/test-data.hbs tests/AttributeTestData.elm
echo "Generating assistance for Outcome ..."
npx baldrick-whisker@latest render --diff generated/outcome.json script/template/test-data.hbs tests/OutcomeTestData.elm
echo "Generating assistance for Validation ..."
npx baldrick-whisker@latest render --diff generated/validation.json script/template/test-data.hbs tests/ValidationTestData.elm
