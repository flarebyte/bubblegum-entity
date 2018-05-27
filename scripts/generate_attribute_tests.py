#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import firstUpper, camelCaseUpper, quoteArray, readCsv
from attribute_template import *
from attribute_meta import *
from parse_elm import *  

ui_keys_csv = "validation.csv"

def formatMethodTemplate(template, row, state, okIf):
        m = {}
        m["name"] = row["name"]
        m["nameU"] = firstUpper(row["name"])
        m["returned"] = row["returned"]
        m["state"] = state
        m["stateU"] = camelCaseUpper(state)
        m["ok"] = okIf
        for ii, param in enumerate(row["params"]):
            paramName = "paramName{ii}".format(ii=ii)
            paramType = "paramType{ii}".format(ii=ii)
            m[paramName] = param[0]
            m[paramType] = param[1]
        print m
        return Template(template).substitute(m)

def formatMethodHeader(name):
        return Template(headerTestFile).substitute(
            moduleName=name
            )
   

def createTests():
    file = open("../tests/AttributeTests2.elm", "w")
    file.write(formatMethodHeader("Attribute"))
    elmLines = readElmFileAsLines('../src/Bubblegum/Entity/Attribute.elm')
    methodNames = getMethodNames(elmLines)
    for method in methodNames:
        methodName = method["name"]
        if methodName not in testableFunctions:
            continue
        content = []
        okIf = metaOk[methodName]   
        for state in metaStates[methodName]:
            content.append(formatMethodTemplate(unitTestValid2, method, state, okIf))
        file.write("            ,".join(content))
    file.close()    


def main(argv):
    createTests()
     
if __name__ == "__main__":
   main(sys.argv[1:])