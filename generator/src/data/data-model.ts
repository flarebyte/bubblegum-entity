import { FunctionInfo } from "../parse-elm-function";

export interface MetaState {
  name: string;
}
export interface FunctionMeta {
  name: string;
  states: MetaState[];
}

export interface ExtendedFunctionInfo extends FunctionInfo {
  states: MetaState[];
}

export interface FunctionTemplateInfo {
  function: ExtendedFunctionInfo;
}

export const toFunctionMetaObject = (
  metaArray: FunctionMeta[]
): { [name: string]: FunctionMeta } =>
  Object.fromEntries(metaArray.map((m) => [m.name, m]));

export const mergeWithExtendedMeta = (
  functionInfo: FunctionInfo,
  meta: FunctionMeta
): ExtendedFunctionInfo => ({
  ...functionInfo,
  states: meta.states,
});
