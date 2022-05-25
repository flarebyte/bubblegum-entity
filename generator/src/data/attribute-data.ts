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
const ok = "ok2"
export const attributesData: FunctionMeta[] = [
  {
    name: "findAttributeByKey",
    states: [justModel, nothing],
    ok
  },
  {
    name: "findAttributeFirstValueByKey",
    states: [justString, nothing],
    ok
  },
  {
    name: "findOutcomeByKey",
    states: [validOutcome, noneOutcome],
    ok
  },
  {
    name: "findOutcomeByKeyTuple",
    states: [validOutcome, outcomeWithFirstNone],
    ok
  },
  {
    name: "deleteAttributeByKey",
    states: [list, emptyList],
    ok
  },
  {
    name: "replaceAttributeByKey",
    states: [list, emptyList],
    ok
  },
];
