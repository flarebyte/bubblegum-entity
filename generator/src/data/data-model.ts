import { FunctionInfo } from "../parse-elm-function";

export interface MetaState {
  stateName: string;
}
export interface FunctionMeta {
  name: string;
  states: MetaState[];
}

export interface ExtendedFunctionInfo extends FunctionInfo {
  states: MetaState[];
}

export interface TemplateInfo {
  templateName: string;
  targetDir: string;
  targetName: string;
  packageName: string;
  moduleName: string;
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
