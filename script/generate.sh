#!/bin/sh
echo "Generating Attribute ..."
npx baldrick-whisker@latest object generated/attribute.json src/Bubblegum/Entity/Attribute.elm script/data/attribute.json
npx ajv validate --errors text -s script/schema/merged.schema.json -d generated/attribute.json
npx baldrick-whisker@latest render generated/attribute.json script/template/tests.hbs tests/AttributeTests.elm
echo "Generating Outcome ..."
npx baldrick-whisker@latest object generated/outcome.json src/Bubblegum/Entity/Outcome.elm script/data/outcome.json
npx ajv validate --errors text -s script/schema/merged.schema.json -d generated/outcome.json
npx baldrick-whisker@latest render generated/outcome.json script/template/tests.hbs tests/OutcomeTests.elm
echo "Generating Validation ..."
npx baldrick-whisker@latest object generated/validation.json src/Bubblegum/Entity/Validation.elm script/data/validation.json
npx ajv validate --errors text -s script/schema/merged.schema.json -d generated/validation.json
npx baldrick-whisker@latest render generated/validation.json script/template/tests.hbs tests/ValidationTests.elm
