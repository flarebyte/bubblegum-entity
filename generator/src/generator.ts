import { readElmContent } from "./elm-io";

console.log('prepare');
const generate = async () => {
  console.log('Stating generation ...');
  const attrContent = await readElmContent('Attribute');
  console.log(attrContent)
};

await generate();

export { generate };