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
