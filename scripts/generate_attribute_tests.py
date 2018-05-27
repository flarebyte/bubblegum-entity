#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import firstUpper, camelCaseUpper, quoteArray, readCsv
from method_template import *
from method_meta import *
from generate_method import *
from parse_elm import *  

def createTests():
    file = open("../tests/AttributeTests.elm", "w")
    file.write(formatMethodHeader("Attribute"))
    elmLines = readElmFileAsLines('../src/Bubblegum/Entity/Attribute.elm')
    methodNames = getMethodNames(elmLines)
    for method in methodNames:
        methodName = method["name"]
        if methodName not in testableFunctions:
            continue
        content = []
        okIf = meta[methodName]["ok"]
        shouldUpdateTest = True
        if shouldUpdateTest:
            print(formatMethodTemplate(unitTestDataHeader2, method, "z", 0))
        for state in meta[methodName]["states"]:
            content.append(formatMethodTemplate(unitTestValid2, method, state, okIf))
            if shouldUpdateTest:
                print(formatMethodTemplate(unitTestDataState2, method, state, okIf))
        file.write("            ,".join(content))
    file.close()    


def main(argv):
    createTests()
     
if __name__ == "__main__":
   main(sys.argv[1:])