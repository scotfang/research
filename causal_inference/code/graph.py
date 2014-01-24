#Causal Structures
##  scotfang 1/14/2014

class Node(object):
    def __init__(self, name, isAndNode, parent=None, children=[], timeout=None): 
        """
        Input args:
            name - Name of Node, i.e. 'light_on'  
            isAndNode - [Boolean] if False, implies this is an OrNode. 
            parent - Single parent Node.
            children - List of Child Nodes.
            timeout - How long we're willing to wait for fluent change to happen. 

        Or Nodes have uniform switching probability among their children.
        """

        self.name = name
        self.isAndNode = isAndNode
        self.parent = parent
        self.children = children
        self.timeout = timeout

    def isRoot(self):
        return not self.parent

    def isLeaf(self):
        return not self.children

class EventNode(Node):
    "An event, i.e. Scot picks up the cup."
    def __init__(self, NonEvent, *args, **kwds):
        "[Boolean]NonEvent means the action failed 
        self.

class FluentNode(Node):
    "The state of an object, i.e. light:ON or light:OFF"
    pass

class PrevFluentNode(Node):
    "The state of an object, that is a precondition for events and fluents."
    pass
