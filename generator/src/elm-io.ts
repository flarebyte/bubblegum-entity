import path from "node:path";
import jetpack from "fs-jetpack";
import { FunctionInfo, parseElmFunctions } from "./parse-elm-function.js";
const elmSourceDir = "../src/Bubblegum/Entity";

export const readElmContent = async (name: string): Promise<string> => {
  const filename = path.join(elmSourceDir, `${name}.elm`);
  const content =
    (await jetpack.readAsync(filename, "utf8")) || "// Snippet not found";
  return content;
};

/**
 * Load a list of elm functions
 * @param name the elm file name
 * @returns 
 */
export const readElmFunctions = async (name: string): Promise<FunctionInfo[]> => {
  const content = await readElmContent(name);
  return parseElmFunctions(content);
};
