#!/usr/bin/env python
#  Semi-Markov and Markov Fluent Transitions.

#import utils
import fluent_models as fm

from pygraph.classes.digraph import digraph     # directed graph
from pygraph.algorithms.accessibility import connected_components
import pygraphviz as pgv

from itertools import combinations_with_replacement

class SemiMarkov(object):
    def __init__(self, inputFluent, outputFluents, 
                transFunc, temporalDomain=(0, None)):
        """
        Represents a transition from fluentDomain --> fluentImage. This is a 
        many-to-many-relation, with probabilities associated with each output .  
        The transition may be dependent on the state duration of the input 
        fluent, i.e. Semi-Markov. 

        It can be represented as a stochastic function with a noise variable to
        make it a many-to-one relation. This may be useful for do-calculus.
        
        Input args:
            inputFluent: Single input fluent. 
            outputFluents: Set of output fluents.
            temporalDomain (t1, t2): Time span this transition is defined over. 
                t2 == None indicates infinity.  The number of time quantums
                represents the state duration of the input fluent.
            transFunc: Function that takes state duration as input, and returns 
                a list probabilities corresponding to respective outputs in 
                outputFluents.
        """
        self.inputFluent = inputFluent
        self.outputFluents = outputFluents
        self.temporalDomain = temporalDomain
        self.transFunc = transFunc

    def tr(self, time):
        """
        Evaluate transFunc for with input time, and return a list of
        [(prob1, outputFluent1), (prob2, outputFluent2)...]
        """
        tmin, tmax = self.temporalDomain
        assert time >= tmin
        assert time <= tmax or tmax is None #None == time_infinity
        probs = self.transFunc(time)
        assert sum(probs) == 1
        assert len(probs) == len(self.outputFluents) 
        return zip(probs, self.outputFluents)

    def __str__(self):
        return str(self.inputFluent)

    def contains(self, targetFluent):
        """
        Returns true if inputFluent or any single outputFluent subsumes 
        targetFluent.
        """
        if self.inputFluent.subsumes(targetFluent):
            return True
        for of in self.outputFluents:
            if of.subsumes(targetFluent):
                return True
        return False


class Markov(object):
    "Homogenous Fluent Transition (Markov). Otherwise same as SemiMarkov."
    
    def __init__(self, inputFluent, outputFluents, imageProbs):
        """
        Input args:
            inputFluent: Single input Fluent.
            outputFluents: Multiple output fluents.
            imageProbs: Respective probabilities of outputFluents.
        """
        assert len(outputFluents) == len(imageProbs)
        assert sum( imageProbs )  == 1
        self.inputFluent = inputFluent
        self.outputFluents = outputFluents 
        self.imageProbs = imageProbs
        self.temporalDomain = (0, None) 

    def tr(self):
        "Return homogenous transition probability."
        return zip(self.imageProbs, self.outputFluents)

    def __str__(self):
        return str(self.inputFluent)

    def contains(self, targetFluent):
        """
        Returns true if inputFluent or any single outputFluent subsumes 
        targetFluent.
        """
        if self.inputFluent.subsumes(targetFluent):
            return True
        for of in self.outputFluents:
            if of.subsumes(targetFluent):
                return True
        return False

class Graph(digraph):
    """"
    Build a directed graph of SemiMarkov/Markov Transitions. A-->B indicates
    that one of A's output fluents is B's input fluent.
    """
    def __init__(self, transitions):
        "transitions - Sequence of target transitions."
        super(Graph, self).__init__()  
        for t in transitions:
            self.add_node(t)
        for A, B in combinations_with_replacement(transitions, 2):
            #Check each possible edge in transitions.
            if B.inputFluent in A.outputFluents:
                self.add_edge((A, B))
            if B == A: #Add self-loop-edge only once
                continue
            if A.inputFluent in B.outputFluents:
                self.add_edge((B, A))

    def getCcp(self, targetFluent): 
        """
        Returns all connected components in this graph that contain
        targetFluent. 

        Note: For a connected component to 'contain' targetFluent at least
        one node must contain ALL of targetFluent's leaf nodes (atomic fluents)
        .
        """
        containers = [ n for n in self.nodes() if n.contains(targetFluent) ]
        ccpMap = connected_components(self) #dict: node -> ccpNumber
        tarCcpNumbers = set() 
        for node in containers:
            tarCcpNumbers.add(ccpMap[node])

        ccp = [] #List of connected components
        for i in tarCcpNumbers:
            ccp.append([ node for node, num in ccpMap.items() if num == i ])

        return ccp


    def toWritable(self):
        """
        Create a writable graph for visualization.

        Returns:
            pygraphviz.Agraph() 

        """

        # Make graph dot-writable by converting all nodes to strings. 
        writable = pgv.AGraph(directed=True, strict=False)
        for n in self.nodes():
            writable.add_node(str(n))
        for A, B in self.edges():
            # Convert nodes to strings.
            writable.add_edge(str(A), str(B)) 

        return writable

class FluentGraph(digraph):
    def __init__(self, targetFluents, allTransitions):
        
        # Extract all Leaf fluents from targetFluents.
        leafs = [] 
        for f in targetFluents:
            leafs.extend(f.getLeafs())
        leafs = set(leafs)

        for t in allTransitions:
            pass
                
class CausalGraph(digraph):
    """
    A causal forest of all possible: 
    FluentTree->OrFluentTransition->FluentTree->OrFluentTransition cycles.
    Represents the Action->Fluent->Action->Fluent cycle concept.
    
    All nodes are AndNodes, representing a FluentTree.

    All directed edges go from a single parent FluentTree to one or more
    child FluentTrees. The edges represent fluent transitions, which are 
    semantically equivalent to OR nodes.

    Edges weights are OR probabilities. 
    Edges also have timeWindows for fluentTransitions.
    All edge weights for a given timeWindow must sum to 1.
    """

    def __init__(self):
        super(CausalGraph, self).__init__() #Init base class

    def addFluentNode(self, node):
        assert type(node) == nodes.FluentTree
        self.add_node(node)

    def addFluentTransition(self, parentNode, childNodes, childProbs, 
        timeWindow=None):
        """
        A FluentTransition is represented by an OrRelation from a single parent
        FluentTree to a set of possible child FluentTrees with switching 
        probabilities summed to one.  This transition must take place in a 
        timeWindow global to all children.

        Input args:
            parentNode: Input FluentTree.
            childNodes: List of Output FluentTrees.
            childProbs: List of associated probabilties for each childNode.
            timeWindow: Global timeWindow for transition to take place in.
        """

        assert type(parentNode) == nodes.FluentTree
        assert len(childNodes) == len(childProbs)
        assert sum(childProbs) == 1

        for i, child in enumerate(childNodes):
            assert type(child) == nodes.FluentTree
            self.add_edge((parentNode, child), wt=childProbs[i], 
                          attrs=timeWindowAttrs)

    def toWritable(self):
        """
        Create a writable graph of CausalGraph for visualization.
        
        Returns:
            pygraphviz.Agraph() 

        DOT attributes used:
            -'group' for OR switch nodes
            -
        """

        # Make graph dot-writable by converting all fluent nodes to strings. 
        writable = pgv.AGraph(directed=True)
        for fluentA, fluentB in self.edges():
            # Convert nodes to strings.
            rootA = fluentA.root()
            strA = rootA.name + ":" + str(rootA.state)  
            if not writable.has_node(strA):
                writable.add_node(strA)

            rootB = fluentB.root()
            strB = rootB.name + ":" + str(rootB.state)  
            if not writable.has_node(strB):
                writable.add_node(strB)

            writable.add_edge((strA, strB)) 

        return writable
