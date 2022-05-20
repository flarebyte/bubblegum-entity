import { attributesData } from "./data/attribute-data.js";
import { mergeElmFunctions } from "./elm-io.js";

console.log("prepare");

const generateExtendedModel = async () => {
  console.log("Generate extended models ...");
  await mergeElmFunctions("Attribute", attributesData);
  await mergeElmFunctions("Outcome", []);
  await mergeElmFunctions("Validation", []);
};
const generate = async () => {
  console.log("Starting generation ...");
  await generateExtendedModel();
};

await generate();

export { generate };
