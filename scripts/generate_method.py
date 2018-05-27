#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import firstUpper, camelCaseUpper, quoteArray, readCsv
from method_template import *
from method_meta import *
from parse_elm import *  

def formatMethodTemplate(template, row, state, okIf):
        m = {}
        m["name"] = row["name"]
        m["nameU"] = firstUpper(row["name"])
        m["returned"] = row["returned"]
        m["state"] = state
        m["stateU"] = camelCaseUpper(state)
        m["ok"] = "ok{}".format(okIf)
        for ii, param in enumerate(row["params"]):
            paramName = "paramName{ii}".format(ii=ii)
            paramType = "paramType{ii}".format(ii=ii)
            m[paramName] = param[0]
            m[paramType] = param[1]
        return Template(template).substitute(m)

def formatMethodHeader(name):
        return Template(headerTestFile).substitute(
            moduleName=name
            )
