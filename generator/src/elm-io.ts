import path from "node:path";
import jetpack from "fs-jetpack";
import { FunctionInfo, parseElmFunctions } from "./parse-elm-function.js";
import {
  FunctionMeta,
  mergeWithExtendedMeta,
  ExtendedFunctionInfo,
  toFunctionMetaObject,
} from "./data/data-model.js";
const elmSourceDir = "../src/Bubblegum/Entity";
const generatedDir = "../generated";

export const readElmContent = async (name: string): Promise<string> => {
  const filename = path.join(elmSourceDir, `${name}.elm`);
  const content =
    (await jetpack.readAsync(filename, "utf8")) || "// Snippet not found";
  return content;
};

/**
 * Load a list of elm functions
 * @param name the elm file name
 */
export const readElmFunctions = async (
  name: string
): Promise<FunctionInfo[]> => {
  const content = await readElmContent(name);
  return parseElmFunctions(content);
};

/**
 * Delete previously generated folder
 */
export const deleteGenerated = async () => {
  console.log("Deleting generated folder");
  await jetpack.removeAsync(generatedDir);
};

export const mergeElmFunctions = async (
  name: string,
  metas: FunctionMeta[]
): Promise<ExtendedFunctionInfo[]> => {
  const elmFunctions = await readElmFunctions(name);
  const metaDict = toFunctionMetaObject(metas);
  const defaultFunctionMeta: FunctionMeta = { name: "", states: [] };
  const extendedFunctions = elmFunctions.map((fn) =>
    mergeWithExtendedMeta(fn, metaDict[fn.name] || defaultFunctionMeta)
  );
  return extendedFunctions;
};
