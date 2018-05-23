#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import camelCase, camelCaseUpper, quoteArray, readCsv
from attribute_template import *
from parse_elm import *  

ui_keys_csv = "validation.csv"

def formatMethodTemplate(template, row):
        return Template(template).substitute(
            name=row["name"],
            nameCamelUpper=camelCaseUpper(row["name"]),
            returned=row["returned"],
            params=row["params"],
            )
   
def formatMethodHeader(name):
        return Template(headerTestFile).substitute(
            moduleName=name
            )
   

def createTests():
    file = open("../tests/AttributeTests2.elm", "w")
    file.write(formatMethodHeader("Attribute"))
    elmLines = readElmFileAsLines('src/Bubblegum/Entity/Attribute.elm')
    methodNames = getMethodNames(elmLines)
    for method in methodNames:
        formatMethodTemplate()
    file.close()    


def main(argv):
    createTests()
     
if __name__ == "__main__":
   main(sys.argv[1:])