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

def parseMethodSignature(lines, line):
    methodName, signature = line.split(":", 2)
    signParams = stripStringList(signature.split("->"))
    paramTypes = signParams[:-1]
    paramNames = stripStringList(findParameterNames(lines, methodName))
    params = zip(paramNames, paramTypes)
    return {'name': methodName.strip(), 'params': params, 'returned': paramTypes[-1].strip()}

def matchMethodName(line, methodName):
    return line.startswith(methodName) and line.endswith("=")

def extractParamName(line, methodName):
    return line.replace(methodName, '').replace('=','').strip().split()

def findParameterNames(lines, methodName):
    for line in lines:
        if matchMethodName(line, methodName):
            return extractParamName(line, methodName) 
