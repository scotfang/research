#!/usr/bin/env python
# Fluent objects.

from pygraph.classes.digraph import digraph     # directed graph
from pygraph.readwrite import dot
import pygraphviz as pgv


class Node(object):
    "Node Fluent - The state of an entity/object."
    def __init__(self, name, state, probEmit=None):
        """
        probEmit - Likelihood that fluent will be detected locally in a
                   single frame. P(detection | fluent).
        """
        assert probEmit is None or (probEmit>=0 and probEmit<=1)
        self.name = name
        self.state = state
        self.probEmit = probEmit 

    def sig(self):
        "Node Signature"
        return ( self.name, self.state )

    def subsumes(self, other):
        if isinstance(other, Node):
            return set([self.sig()]) >= set([other.sig()])
        elif isinstance(other, Tree):
            return set([self.sig()]) >= set(other.sig())
        else:
            assert False

    def __str__(self):
        return "%s:%s" % (str(self.name), str(self.state))

    def __repr__(self):
        return "Node(name=%s, state=%s, probEmit=%s)" % \
               (str(self.name), str(self.state), str(self.probEmit))

        
class Tree(digraph):
    """
    Fluent Trees compose atomic fluents in a hierarchy. A Tree represents the
    simultaneous existence of atomic fluents. They are semantically equivalent
    to a tree of And Nodes.
    """
    def __init__(self, name, state, probEmit=None, rootChildren=None):
        "Init fluent tree with a root fluent node."
        super(Tree, self).__init__() #Init base class
        self.root = Node(name, state, probEmit)
        self.add_node(self.root)
        if rootChildren:
            self.addRootChildren(rootChildren)

    def addFluent(self, fluent):
        "Fluent can be Node or Tree."
        self.add_node(fluent) 

    def addFluents(self, fluents):
        for fluent in fluents:
            self.add_node(fluent) 
    
    def addEdge(self, parent, child):
        self.add_edge((parent, child))

    def addRootChildren(self, children):
        for fluent in children:
            self.add_node(fluent)
            self.add_edge((self.root, fluent))

    def getLeafs(self):
        "Extract all Leaf fluents."
        leafs = []
        for n in self.nodes():
            if isinstance(n, Tree): #recursively getLeafs for subtrees
                leafs.extend(n.getLeafs())
            elif isinstance(n, Node):
                if self.node_order(n) == 0: #no outgoing edges
                    leafs.append(n)
            else:
                assert False
                 
        return leafs

    def toWritable(self):
        """
        Create a writable graph of FluentTree for visualization.
        
        Returns:
            pygraphviz.Agraph() 
        """
        # Make graph dot-writable by converting all fluent nodes to strings. 
        writable = pgv.AGraph(directed=True)
        for x, y in self.edges():
            if not writable.has_node(str(x)):
                writable.add_node(str(x))
            if not writable.has_node(str(y)):
                writable.add_node(str(y))
            writable.add_edge((str(x), str(y))) 
        return writable

    def sig(self):
        "FluentTree signature composed of all leaf nodes."
        return list(sorted([ n.sig() for n in self.getLeafs() ], 
                key=lambda x: (x[0], x[1])))

    def subsumes(self, other):
        if isinstance(other, Node):
            return set(self.sig()) >= set([other.sig()])
        elif isinstance(other, Tree):
            return set(self.sig()) >= set(other.sig())
        else:
            assert False

    def __str__(self):
        return str(self.root)

    def __repr__(self):
        return ', '.join([ n.__repr__() for n in self.nodes() ])
        

def test_writeSimpleTree():
    """
    Create a simple tree and visualize it in dot format.
    """ 
    foo = Node('foo', True)
    bar = Node('bar', False)
    
    foobar = Tree('foobar', True)
    foobar.addRootChildren([foo, bar])

    albert = Node('albert', True)
    fatAlbert = Tree('fatAlbert', True)
    fatAlbert.addRootChildren([albert, foobar])
    print "Leafs", str([ str(a) for a in fatAlbert.getLeafs()])
    print "Signature", str(fatAlbert.sig())
    assert ('foo', True) in fatAlbert.sig()

    writable = fatAlbert.toWritable()
    print writable.string()
    writable.draw('fatAlbert_dot.png', prog='dot')
    writable.draw('fatAlbert_neato.png', prog='neato')

    return foobar, foo


if __name__ == "__main__":
    test_writeSimpleTree()
