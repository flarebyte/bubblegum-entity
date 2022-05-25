import { FunctionMeta, MetaState } from "./data-model";

const justModel: MetaState = {
  stateName: "just model",
};
const justString: MetaState = {
  stateName: "just string",
};
const nothing: MetaState = {
  stateName: "nothing",
};
const validOutcome: MetaState = {
  stateName: "valid outcome",
};
const noneOutcome: MetaState = {
  stateName: "none outcome",
};
const outcomeWithFirstNone: MetaState = {
  stateName: "outcome with first none",
};
const list: MetaState = {
  stateName: "list",
};
const emptyList: MetaState = {
  stateName: "empty list",
};
export const attributesData: FunctionMeta[] = [
  {
    name: "findAttributeByKey",
    states: [justModel, nothing],
  },
  {
    name: "findAttributeFirstValueByKey",
    states: [justString, nothing],
  },
  {
    name: "findOutcomeByKey",
    states: [validOutcome, noneOutcome],
  },
  {
    name: "findOutcomeByKeyTuple",
    states: [validOutcome, outcomeWithFirstNone],
  },
  {
    name: "deleteAttributeByKey",
    states: [list, emptyList],
  },
  {
    name: "replaceAttributeByKey",
    states: [list, emptyList],
  },
];
