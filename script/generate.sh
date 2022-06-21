#!/bin/sh
npx baldrick-whisker@latest object generated/attribute.json src/Bubblegum/Entity/Attribute.elm script/data/attribute.json
npx baldrick-whisker@latest object generated/outcome.json src/Bubblegum/Entity/Outcome.elm script/data/outcome.json
npx baldrick-whisker@latest object generated/validation.json src/Bubblegum/Entity/Validation.elm script/data/validation.json
npx baldrick-whisker@latest render generated/attribute.json script/template/tests.hbs tests/AttributeTests.elm
npx baldrick-whisker@latest render generated/outcome.json script/template/tests.hbs tests/OutcomeTests.elm
npx baldrick-whisker@latest render generated/validation.json script/template/tests.hbs tests/ValidationTests.elm
