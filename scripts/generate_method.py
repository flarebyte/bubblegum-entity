#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import firstUpper, camelCaseUpper, quoteArray, readCsv, readFileAsString
from method_template import *
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

def createTests(packageName, moduleName, meta):
    file = open("../tests/{moduleName}Tests.elm".format(moduleName = moduleName), "w")
    file.write(formatMethodHeader(packageName, moduleName))
    elmLines = readElmFileAsLines("../src/{packageName}/{moduleName}.elm".format(packageName=packageName, moduleName=moduleName))
    existingTestDataContent = readFileAsString("../tests/{moduleName}TestData.elm".format(moduleName = moduleName))
    methodNames = getMethodNames(elmLines)
    testableFunctions = meta.keys()
    wholeContent = []
    for method in methodNames:
        methodContent = ""
        methodName = method["name"]
        if methodName not in testableFunctions:
            continue
        numberOfParams = len(method["params"]) -1
        content = []
        shouldUpdateTest = not ("-- {methodName}".format(methodName=methodName)) in existingTestDataContent
        if shouldUpdateTest:
            print(formatMethodTemplate(unitTestDataHeader[numberOfParams], method, moduleName))
        methodContent += formatMethodTemplate(unitTestHeader, method, moduleName)  
        for state in meta[methodName]["states"]:
            content.append(formatMethodTemplate(unitTestValid[numberOfParams], method, moduleName, state, meta[methodName]))
            if shouldUpdateTest:
                print(formatMethodTemplate(unitTestDataState[numberOfParams], method, moduleName, state, meta[methodName]))
        methodContent += ("\n            ,".join(content))
        methodContent += ("\n            ]")
        wholeContent.append(methodContent)
    file.write("            , ".join(wholeContent))
    file.write("\n        ]")
    file.close()    
