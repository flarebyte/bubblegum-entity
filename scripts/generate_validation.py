#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import camelCase, camelCaseUpper, quoteArray, readCsv
from vocabulary_template import * 

ui_keys_csv = "validation.csv"

def formatTemplate(template, row):
        nameField, descriptionField, signatureField, extra, examplesField = row
        name = nameField.strip()
        description = descriptionField.strip()
        signature = signatureField.strip()
        namecamel = camelCase(name)
        nameCamel = camelCaseUpper(name)
        rangeRestriction=checkRangeRestriction(extra)
        examples = generateExamples(examplesField, signature)
        return Template(template).substitute(
            name=name,
            description=description,
            signature=signature,
            namecamel=namecamel,
            nameCamel=nameCamel,
            rangeRestriction=rangeRestriction,
            examples = examples
            )
   

def createVocabulary():
    content = readCsv(ui_keys_csv)
    file = open("../src/Bubblegum/Entity/Validation2.elm", "w")
    file.write(headerVocabulary)
    for row in content:
        if len(row) > 2 :
            file.write(formatTemplate(templateVocabulary, row))
    file.close()    

                  file.write(formatTemplate(templateWidgetCreateTestsSettingsWrong, row))
                withComa = True
            if isUserSettings(row):
                content = prefixWithComa("fuzz ", withComa, formatTemplate(templateWidgetCreateTestsUserSettingsCorrect, row))
                file.write(content)
                if isAttribute(row):
                    file.write(formatTemplate(templateWidgetCreateTestsUserSettingsWrongAttr, row))
                else:
                    file.write(formatTemplate(templateWidgetCreateTestsUserSettingsWrong, row))
                withComa = True
            if isState(row):
                content = prefixWithComa("fuzz ", withComa, formatTemplate(templateWidgetCreateTestsStateCorrect, row))
                file.write(content)
                if isAttribute(row):
                    file.write(formatTemplate(templateWidgetCreateTestsStateWrongAttr, row))
                else:
                    file.write(formatTemplate(templateWidgetCreateTestsStateWrong, row))
                withComa = True
    file.write(footerWidgetCreateTests)            
    file.close()    



def main(argv):
    createVocabulary()
     
if __name__ == "__main__":
   main(sys.argv[1:])