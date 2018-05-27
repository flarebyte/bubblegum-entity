#!/usr/bin/python

def setMeta(ok, states):
    return { 
            'states': states,
            'ok': ok
        }

metaAttribute = {
    'findAttributeByKey': setMeta(2, ["just model", "nothing"])
    }
