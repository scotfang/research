# Parse Objects used as input to causal reasoning.
##  scotfang 1/14/2014

class Event(object):
    "Events parse."
    def __init__(self, name, agent, energy):
        self.name = name
        self.agent = agent
        self.energy = energy
        #self.class = class

class FluentChange(object):
    "FluentChange parse."
    def __init__(self, fluentName, changeEnergy):
        self.name = fluentName
        self.energy = changeEnergy
        #self.class = class

class FrameDict(dict):
    """
    Key=FrameNumber, Value=List of arbitrary items.
    Use to represent sets of parse objects per frame.
    """ 

    def add(self, frameNumber, item):
        if frameNumber not in self:
            self[frameNumber] = list()
        self[frameNumber].append(item)
