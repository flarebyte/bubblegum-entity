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
    'trueMapToConstant': setMeta(2, ["true", "false"])
    # 'or': setMeta(2, ["valid", "none", "warning"]),
    # 'fromMaybe': setMeta(2, ["valid", "none"]),
    # 'toMaybe': setMeta(2, ["just", "nothing"])
    }
