#!/usr/bin/python

def setMeta(ok, states):
    return { 
            'states': states,
            'ok': ok
        }

metaAttribute = {
    'findAttributeByKey': setMeta(2, ["just model", "nothing"]),
    'findAttributeFirstValueByKey': setMeta(2, ["just string", "nothing"]),
    'findOutcomeByKey': setMeta(2, ["valid outcome", "none outcome"]),
    'findOutcomeByKeyTuple': setMeta(2, ["valid outcome", "outcome with first none"]),
    'deleteAttributeByKey': setMeta(2, ["list", "empty list"]),
    'replaceAttributeByKey': setMeta(2, ["list", "empty list"])
    }

metaOutcome = {
    'withDefault': setMeta(2, ["valid", "none"]),
    'map': setMeta(2, ["valid", "none", "warning"]),
    'map2': setMeta(2, ["valid", "none", "warning"]),
    'check': setMeta(2, ["valid", "none", "warning", "check failed"]),
    'checkOrNone': setMeta(2, ["valid", "check failed", "warning"]),
    'trueMapToConstant': setMeta(2, ["true", "false"]),
    'or': setMeta(2, ["first", "second"]),
    'fromMaybe': setMeta(2, ["valid", "none"]),
    'toMaybe': setMeta(1, ["just", "nothing"])
    }

metaValidation = {
    'asIntRange': setMeta(1, ["valid", "invalid"]),
    'asFloatRange': setMeta(1, ["valid", "invalid"]),
    'withinIntRange': setMeta(1, ["inside range", "outside range"]),
    'withinFloatRange': setMeta(1, ["inside range", "outside range"]),
    'listStrictlyLessThan': setMeta(1, ["valid", "invalid"]),
    'listStrictlyMoreThan': setMeta(1, ["valid", "invalid"]),
    'matchAbsoluteUrl': setMeta(1, ["valid", "invalid"]),
    'matchEnum': setMeta(1, ["valid", "invalid"]),
    'matchCompactUri': setMeta(1, ["valid", "invalid"]),
    'stringStartsWith': setMeta(1, ["valid", "invalid"]),
    'withinStringCharsRange': setMeta(1, ["valid", "invalid"])
    # 'withinListStringCharsRange': setMeta(1, ["valid", "invalid"])
    }
