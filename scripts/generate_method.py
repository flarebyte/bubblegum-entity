#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import firstUpper, camelCaseUpper, quoteArray, readCsv
from method_template import *
from method_meta import *
from parse_elm import *  

defaultMeta = { 
            'states': [""],
            'ok': 0
        }

def formatMethodTemplate(template, row, moduleName, state = "z", meta = defaultMeta):
        m = {}
        m["name"] = row["name"]
        m["moduleName"] = moduleName
        m["nameU"] = firstUpper(row["name"])
        m["returned"] = row["returned"]
        m["state"] = state
        m["stateU"] = camelCaseUpper(state)
        m["ok"] = "ok{okNumber}".format(okNumber = meta["ok"])
        for ii, param in enumerate(row["params"]):
            paramName = "paramName{ii}".format(ii=ii)
            paramType = "paramType{ii}".format(ii=ii)
            m[paramName] = param[0]
            m[paramType] = param[1]
        return Template(template).substitute(m)

def formatMethodHeader(packageName, moduleName):
        return Template(headerTestFile).substitute(
            moduleName = moduleName,
            packageName = packageName,
            packageNameDot = packageName.replace('/','.')
            )

def createTests(packageName, moduleName):
    file = open("../tests/{moduleName}Tests.elm".format(moduleName = moduleName), "w")
    file.write(formatMethodHeader(packageName, moduleName))
    elmLines = readElmFileAsLines("../src/{packageName}/{moduleName}.elm".format(packageName=packageName, moduleName=moduleName))
    methodNames = getMethodNames(elmLines)
    for method in methodNames:
        methodName = method["name"]
        if methodName not in testableFunctions:
            continue
        content = []
        okIf = meta[methodName]["ok"]
        shouldUpdateTest = False
        if shouldUpdateTest:
            print(formatMethodTemplate(unitTestDataHeader2, method, moduleName))
        file.write(formatMethodTemplate(unitTestHeader2, method, moduleName))    
        for state in meta[methodName]["states"]:
            content.append(formatMethodTemplate(unitTestValid2, method, moduleName, state, meta[methodName]))
            if shouldUpdateTest:
                print(formatMethodTemplate(unitTestDataState2, method, moduleName, state, meta[methodName]))
        file.write("            ,".join(content))
        file.write("\n            ]")
    file.write("\n        ]")
    file.close()    
