#!/usr/bin/env python

import fluent_models as fm
import transition_models as tm
from math import exp

f_light = [ fm.Node('light', 'off', probEmit=0.8), 
            fm.Node('light', 'on', probEmit=0.9) ]
            
f_switch = [ fm.Node('touch_lightSwitch', False, probEmit=0.75),
            fm.Node('touch_lightSwitch', True, probEmit=0.7) ]

ft_switchLight = [ 
    fm.Tree('switch_light', 'off', rootChildren=[f_light[1], f_switch[1]]),   
    fm.Tree('switch_light', 'on', rootChildren=[f_light[0], f_switch[1]]) 
    ]

ft_inert = [    
    fm.Tree('inert_light', 'off', rootChildren=[f_light[0], ft_switchLight[0]]),
    fm.Tree('inert_light', 'on', rootChildren=[f_light[1], ft_switchLight[0]])
    ]

def f_logisticSwitch(time):
    pInert = 1/(1+exp(-(time-5)))
    pSwitch = 1-pInert
    return [ pInert, pSwitch ]

tr_switch = [
    tm.SemiMarkov(ft_switchLight[1], 
                  [ft_inert[1], ft_switchLight[1]], f_logisticSwitch),
    tm.SemiMarkov(ft_switchLight[0], 
                  [ft_inert[0], ft_switchLight[0]], f_logisticSwitch)
            ]

t=10
for tr in tr_switch:
    print str(tr.inputFluent), '------->'
    for prob, outputFluent in tr.tr(t):
        print '    ', prob, str(outputFluent)
    
pInert = 0.95 
pSwitch = 1-pInert

tr_inert = [
    tm.Markov(ft_inert[0], 
              [ft_inert[0], ft_switchLight[1]],
              [pInert, pSwitch]
             ),
    tm.Markov(ft_inert[1], 
              [ft_inert[1], ft_switchLight[0]],
              [pInert, pSwitch]
              )
            ]

for tr in tr_inert:
    print str(tr.inputFluent), '------>'
    for prob, outputFluent in tr.tr():
        print '    ', prob, str(outputFluent)

tr_all = tr_switch + tr_inert
graph = tm.Graph(tr_all)
writable = graph.toWritable()
writable.draw('graphs/demoTransitions_dot.png', prog='dot')
ccp = graph.getCcp(f_light[0])
print "Connected Components for", str(f_light[0])
for i,c in enumerate(ccp):
    print "\tCCP #%d" % (i+1)
    for node in c:
        print '\t\t%s' %  str(node)

    
