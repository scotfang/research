

-----------------
1) Inference data
-----------------

Useful: /Users/amy/Desktop/Video/ExampleCounts.xlsx
* Contains counts of examples where we have F/A detectable/not in the 2 Inference datasets (July recording and Hallway/Boelter9404).
* Lists what I wanted detections for on the summer data

Purpose:
* My stuff links causes (actions) to effects (fluents)
* Using inferred link, can impute fluent/action

---------------------------------------
1A) "hallway video", "zhu office video"
---------------------------------------

Status: RESULTS submitted/rejected to NIPS2012, published in CogSci2013

Scenes:
The data is a hodge-podge of existing data.  I was just using things that were already filmed and had been run through action/fluent detectors.  However, the action detections were not good and the fluent detections were non-existent for Dr. Zhu's office.

Data:
/Users/amy/Desktop/Video/hallway video/
/Users/amy/Desktop/Video/zhu office video/

Human Data:
* the instructions i should have given people: http://classes.thegradekeeper.com/cvpr2012_instructions.php
* experiment website: http://classes.thegradekeeper.com/nips2012.php
* fluents queries: (on tentacle) /home/amy/html/classes/html/ nips2012_1.php, nips2012_2.php,nips2012_3.php,nips2012_4.php
* videos viewed: (on tentacle) /home/amy/html/classes/html/nips2012video/
* /Users/amy/Dropbox/ucla research/inferring/nips2012_1_fulldata.csv , nips2012_2_fulldata.csv

My Annotations: 
/Users/amy/Desktop/Video/hallway video/Amy Summary.txt
/Users/amy/Desktop/Video/zhu office video/Amy Summary.txt

Script/Experiment Design: Doesn't exist; I was using hand-me-down data 

Input to my project:
* Fluent/action detections from the Darpa Demo (for the hallway data).  hallway.xml, pt.xml
* Action detections from Ping's project (for BH 9404).  officeview1.xml, officeview2.xml, officeview3.xml
* Hand-drawn grammar: causal_grammar_hallway.py, causal_grammar_office.py, causal_grammar_office_bigger.py

Results/Observations on Humans:
/Users/amy/Dropbox/ucla research/inferring/AnalyzeHumanResultsFromNIPS2012.pptx

Todos:
* Would be nice to get fluent detections from the Boelter 9404 data (these were originally used for Ping's project)
* Also would be nice to use improved action detections


------------------------------------------------------
1B)  20120729 Video (AKA "July Data" or "Summer Data")
------------------------------------------------------

Status: IN PROGRESS (results not successful)

Scenes: MS 8145, BH 9406, MS Lounge

Data: 
* Data separated out for training are in CVPR2012_action_train and CVPR2012_fluent_train
* Data for testing: CVPR2012_computer_test
* Detections of actions I wanted were hard based on pose alone (Ping Wei's method).
* /Users/amy/Desktop/Video/20120729 Video/Kinect/4DData/DetectableFluentsAndActions.pptx

actionList = ["BENDDOWN", "DRINK", "MAKECALL", "STANDING", "THROWTRASH", "USECOMPUTER", "PRESSBUTTON"]
fluentList = ["OPEN", "CLOSED", "OPEN_CLOSED", "CLOSED_OPEN", "OFF", "ON", "OFF_ON", "ON_OFF", "DIM"]
objectList = ["water", "waterstream", "door", "phone", "trash", "screen", "doorlock", "elevator", "light"]
locationList = ["8145", "lounge", "9406", "9404", "hallway"]

Human Data: 
* experiment website: http://classes.thegradekeeper.com/cvpr2012.php
* instructions to humans: http://classes.thegradekeeper.com/cvpr2012_instructions.php
* What participants saw: CVPR2012_human_test (the jpg's are just screenshots displayed as reference for each cutpoint, the webm's are the video segments) 
* fluent/action queries: (on tentacle) /home/amy/html/classes/html/cvpr2012_data.php

Script/Experiment Design: 
* I have no idea who wrote the script.  It was supposed to be a joint effort, and I tried to contribute, but someone else ultimately put it together.
* /Users/amy/Dropbox/ucla research/inferring/2012-07-27 planning experiments.pptx

Input to my project: 
* Bruce's fluent detections: CVPR2012_fluent_results
* Ping Wei's action detections: CVPR2012_computer_test_action_detection, CVPR2012_computer_test_action_detection_monday (supposedly better detections)
* Hand-drawn causal grammar: causal_grammar_summerdata.py

Sort-of Ground Truth: 
* My annotations (summary of the video): /Users/amy/Desktop/Video/20120729 Video/Kinect/4DData/videosummary.txt

Todo's: 
* Make my code/algorithm work (I left it broken)...  This is the inference code I sent you.
* Improve action detections
* Provide examples for why straight DP is not good enough
* highlight the insertion mechanism


----------------------
1C) Hallway2 (unknown)
----------------------
I have this data, not sure what it was being used for.  I haven't used it yet.


----------------
2) Learning Data
----------------

--------------------------------------
2A) From my first project, filmed 2011
--------------------------------------

Status: RESULTS OBTAINED/PUBLISHED in RepLearn2013 and CogSci2013

Scenes:
* Doorway scenes outside MS 8145, MS 8349 (illustrates the hierarchical capabilities of learning)
* Office scene inside MS 8145 (illustrates the ability to learn causes among many confusing events)
* Elevator scene (illustrates the ability to learn causes when there's a delay before the effect)
* Table/moving book scene inside MS 8145 (not used for results)

Data:
* I only have RGB for this data (even though it was filmed with a Kinect).
* Recorded at 3-6 FPS
* Videos are terrible quality...  I believe most of the fluents/actions would be undetectable on their own.

Script/Experiment Design:
* Video used in experiment: https://www.dropbox.com/s/tgl9whndo2l6449/Jun%202011%20-%20training%20caog%20experimental%20design.xlsx
* Video recorded later that year, not annotated/prepared/used: https://www.dropbox.com/s/qpklmonjq8w8bpc/Oct%202011%20-%20experiments%203.xls
* Script built off annotations (both inside c-aogmatlab folder):
 -- learningScript2012-12.txt
 -- learningScriptElevator.txt

Annotations (inside c-aogmatlab folder):
* Exp1_output_data_key.txt
* Exp1_output_data2.txt
* Exp1_output_data3.txt
* Exp2_output_data.txt

Input to my project:
* Hand annotations for actions and fluents
* Causal relations were not marked (so it was unsupervised learning thereof).

Todos:
* rerun experiments without hand-annotated data (or just run the data from (3) below).
* get journal version accepted


--------------------------------------------------------------------------
2B) Reshooting/expanding learning data from (2A) to make it more realistic
--------------------------------------------------------------------------

Status: IN PROGRESS (No results yet).

Scenes: Office, Elevator, 3 Doorways, 2 views in SCZ office

Script/Experiment Design: https://www.dropbox.com/s/5ch1b5gn81vggfa/experiments%202012-12-18.xlsx

Todos:
* Data needs editing: This data is still only in raw format.  The recordings need to be pruned (there were mistakes with the actors/scenes sometimes, and we just kept recording anyway).  Not only that, apparently the skeleton data was not good (which meant Ping wouldn't be able to extract actions--the actions
* Data needs parsing.
* Data needs to be run through my learning algorithms to learn the causal relationships. 
