#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import camelCase, camelCaseUpper, quoteArray, readCsv
from attribute_template import *
from attribute_meta import *
from parse_elm import *  

ui_keys_csv = "validation.csv"

def formatMethodTemplate(template, row):
        return Template(template).substitute(
            name=row["name"],
            nameU=camelCaseUpper(row["name"]),
            returned=row["returned"],
            params= ["alpha", "beta"]#row["params"][0][0],
            )
   
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
        if method["name"] not in testableFunctions:
            continue
        file.write(formatMethodTemplate(unitTestValid2P1, method))
    file.close()    


def main(argv):
    createTests()
     
if __name__ == "__main__":
   main(sys.argv[1:])