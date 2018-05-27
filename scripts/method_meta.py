#!/usr/bin/python

testableFunctions = ["findAttributeByKey"]

def setMeta(ok, states):
    return { 
            'states': states,
            'ok': ok
        }

meta = {
    'findAttributeByKey': setMeta(2, ["just model", "nothing"])
    }
