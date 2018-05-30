#!/usr/bin/python

def readElmFileAsLines(filename):
    with open(filename, 'r') as myfile:
        return myfile.read().splitlines()

def checkMethodAspect(line):
    return ( "->" in line and ":" in line and not "\\" in line and not "::" in line)

def getMethodNames(lines):
   return [parseMethodSignature(lines, line) for line in lines if checkMethodAspect(line)]

def stripStringList(list):
    return [i.strip() for i in list]   

def replaceArrowWithinParenthesis(text):
    r = ""
    inParen = False
    for letter in text:
        if letter == "(":
           inParen = True
        if letter == ")": 
           inParen = False
        if inParen and letter == "-":
            letter = ""
        if inParen and letter == ">":
            letter = "@"
        r += letter
    return r

def parseParams(signature):
    noArrow = replaceArrowWithinParenthesis(signature)
    params = stripStringList(noArrow.split("->"))
    return [a.replace('@','->') for a in params]

def parseMethodSignature(lines, line):
    methodName, signature = line.split(":", 2)
    signParams = parseParams(signature)
    paramTypes = signParams[:-1]
    paramNames = stripStringList(findParameterNames(lines, methodName))
    params = zip(paramNames, paramTypes)
    return {'name': methodName.strip(), 'params': params, 'returned': signParams[-1].strip()}

def matchMethodName(line, methodName):
    return line.startswith(methodName) and line.endswith("=")

def extractParamName(line, methodName):
    return line.replace(methodName, '').replace('=','').strip().split()

def findParameterNames(lines, methodName):
    for line in lines:
        if matchMethodName(line, methodName):
            return extractParamName(line, methodName) 
