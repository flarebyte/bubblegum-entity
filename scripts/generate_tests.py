#!/usr/bin/python

import sys
from source_meta import *
from generate_method import createTests

def main(argv):
    createTests("Bubblegum/Entity", "Attribute", metaAttribute)
    createTests("Bubblegum/Entity", "Outcome", metaOutcome)
    createTests("Bubblegum/Entity", "Validation", metaValidation)
     
if __name__ == "__main__":
   main(sys.argv[1:])