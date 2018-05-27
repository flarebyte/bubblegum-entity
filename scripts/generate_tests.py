#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import firstUpper, camelCaseUpper, quoteArray, readCsv
from method_template import *
from method_meta import *
from generate_method import *
from parse_elm import *  

def main(argv):
    createTests("Bubblegum/Entity", "Attribute")
     
if __name__ == "__main__":
   main(sys.argv[1:])