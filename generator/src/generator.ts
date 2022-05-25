import { attributesData } from "./data/attribute-data.js";
import { hydrateFunctionTemplate, mergeElmFunctions } from "./elm-io.js";

console.log("prepare");

const generateExtendedModel = async () => {
  console.log("Generate extended models ...");
  await mergeElmFunctions("Attribute", attributesData);
  await mergeElmFunctions("Outcome", []);
  await mergeElmFunctions("Validation", []);
};

const generateTests = async () => {
  console.log("Generate tests in Elm ...");
  await hydrateFunctionTemplate({
    moduleName: "Attribute",
    templateName: "Tests",
    targetDir: "../tests",
    targetName: "AttributeTests",
    packageName: "Bubblegum/Entity",
  });
};
const generate = async () => {
  console.log("Starting generation ...");
  await generateExtendedModel();
  await generateTests();
};

await generate();

export { generate };
