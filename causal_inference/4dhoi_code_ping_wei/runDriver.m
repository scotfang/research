clear,clc

dataDir = 'F:\4DData\2014_3_12';
rawEventFile = fullfile(dataDir, 'events.mat');
event = S2_DumpDataObject(dataDir , rawEventFile);

meanSkeletonFile = fullfile('parameter\4dh_meanskel.mat');
processedEventFile = fullFile(dataDir, 'processedEvents.mat');
processedEvents = S3_Pre_Align_Smooth_Motion(rawEventFile, meanSkeletonFile, processedEventFile);

pcaFile = 'parameter/PCA_Paras.mat';
grammarFile = 'parameter/grammar_short.mat';
resultsFile = fullfile(dataDir, 'results.mat');

[parse_trees] = S7_MainFunction_ActionParsing(grammarFile, processedEventFile, pcaFile, resultsFile, dataDir);