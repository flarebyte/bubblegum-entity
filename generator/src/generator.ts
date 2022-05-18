import { readElmFunctions } from "./elm-io.js";

console.log("prepare");
const generate = async () => {
  console.log("Starting generation ...");
  const attrFunctions = await readElmFunctions("Attribute");
  console.log(JSON.stringify(attrFunctions, null, 2));
};

await generate();

export { generate };
