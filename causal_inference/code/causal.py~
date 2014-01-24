#  Causal structures.
#  scotfang 1/14/2014

def genSignature(nameList):
    for name in nameList:
        assert(type(name) == str)
    sig = sorted(nameList)
    return tuple(sig)

class Fluent(object):
    def __init__(self, fluentName, fluentState, localFluents, globalFluents=None):
        self.fluentName = fluentName
        self.fluentState = fluentState
        self.localFluents = localFluents
        self.globalFluents = globalFluents

        inputFluents = [ fluent.name for fluent in localFluents ]
        if globalFluents:
           names.extend([ fluent.name for fluent in globalFluents ])
        self.signature = genSignature(names) 

class CausalFunction(object):
    def __init__(self, name, inputFluentSignature, isAnd=True, timeWindow=None):
        "timeWindow [scalar:seconds] - Window of time to evaluate occurence of all inputFluents"

        self.name = name
        self.inputFluentSignature = inputFluentSignature
        self.isAnd = isAnd
        self.relations = 

    def addStochasticRelation(self, inputFluent, outputFluent, timeWindow):
        "timeWindow [scalar:seconds] - Window of time outputFluent is expected to occur in presence of inputFluent."

        assert( inputFluent.signature == self.inputFluentSignature, 
                "ERROR: inputFluent %s's signature != CausalFunction %s's signature ====> %s != %s ",
                inputFluent.name, self.name, inputFluent.signature, self.signature )
        if not self.relations:
            self.relations = []
        self.relations.append([timeWindow, inputFluent, outputFluent])
