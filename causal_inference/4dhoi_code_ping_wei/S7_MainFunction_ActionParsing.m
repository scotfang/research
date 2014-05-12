function [parsetrees] = S7_MainFunction_ActionParsing(grammarFile, processedEventsFile, pcaFile, outputFile, dataDir)
%%%%% S8_MainFunction_ActionParsing.m
%%%%% 
tic 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% data struct definition
tree = struct('root',{},'atom',{},'index',{},'frameindex',{},'energy',{});
parsetrees = struct('tree',{},'segment',{},'frameseg',{},'tenergy',{});
%event_name = {'01_drink with mug','02_make a call',...
    %'03_read book','04_use mouse','05_use keyboard',...
    %'06_fetch water','07_pour water','08_press button'};

load(grammarFile, 'grammar');
load(processedEventsFile, 'AlgEvent');    %%% load all skeleton
load(pcaFile);   %%% load PCA parameters

event_name = {};
for i = 1:size(grammar,2)
    %disp(['Processing event ', grammar(i).event]);
    if (~sum( ismember(grammar(i).event, event_name) ) )
        event_name{end+1} = grammar(i).event;
        disp(['Adding event name: ', grammar(i).event]);
    end
end
        
ReadTime = tic
%TRR = 1/3;                         %%% the ratio of training samples
PCN = 20;                          %%% PC number

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% parse each event sequence and output the tree structure
SmpN = zeros(8,1); %number of samples
PosN = zeros(8,1); %number of positive samples
ConMat = zeros(8,8); %confusion matrix
FN = 0;

for i = 1:size(AlgEvent,2)
    
    View = AlgEvent(i).View;
    for j = 1:AlgEvent(i).VNo
        
        Sequence = View(j).Sequence;
        ASI = 1:View(j).SNo;         %%% all sample indexes
        %TRI = 1:(1/TRR):View(j).SNo; %%% training sample indexes
        %TEI = setdiff(ASI,TRI);      %%% testing sample 
        TEI = ASI;
        
        for s = TEI
            
            Frame = Sequence(s).Frame;
            Xm = []; % The frame array of each sequence
            Ym = [];
            tm = 0;  % The frame number of Xm
            
            createdSequenceResultsFile=0;
                     
            for f = 1:Sequence(s).FNo
                if (~isempty(Frame(f).SmoothArms))&(~isempty(Frame(f).MotionArms))
                    tm = tm + 1;
                    frm = zeros(24,1);
                    frm(1:12) = reshape((Frame(f).SmoothArms([1,2,4,5],:)),12,1);
                    motionarms = Frame(f).MotionArms([1,2,4,5],:);
                    for mi = 1:size(motionarms,1)
                        nn = sqrt(motionarms(mi,:)*(motionarms(mi,:))');
                        if nn~= 0
                            motionarms(mi,:) = motionarms(mi,:)/nn;
                        end
                    end
                    frm(13:24) = reshape(motionarms,12,1);
                    pcafrm = Fo2pca(frm',PCA_Coeff,PCA_Sigma,PCA_Mu,PCN);
                    Xm(:,tm) = pcafrm';
                    Ym{1,tm} = [AlgEvent(i).Name,'\',View(j).Name,'\',Sequence(s).Name,'\',Frame(f).Index];
                    %Scot's debug
                    if (~createdSequenceResultsFile)
                        createdSequenceResultsFile = 1;
                        resultsFileName = fullfile(dataDir, AlgEvent(i).Name, View(j).Name, Sequence(s).Name, 'prob_results.txt');
                        sequenceResultsFileId = fopen(resultsFileName, 'w');
                        disp(['Writing sequence results to: ', resultsFileName]);
                    end
                    [max_atom_prb, max_i, event_probs] = Fget_frame_prob(Xm(:,tm), grammar);
                    fprintf(sequenceResultsFileId, 'Frame %s:\n', num2str(Frame(f).Index));
                    fprintf(sequenceResultsFileId, ...
                        '    max_atomic_event_prob (un-normalized):\n        %s %s\n', ...
                        grammar(max_i).atom, num2str(max_atom_prb));
                    [sorted_event_probs, sorted_idx] = sort(event_probs, 'descend');
                    fprintf(sequenceResultsFileId, '    Sorted composite_event_probabilities:\n');
                    for event_i = 1:size(event_probs)
                        fprintf(sequenceResultsFileId, '        %s %s\n', ...
                            event_name{sorted_idx(event_i)}, ...
                            num2str(sorted_event_probs(event_i)));
                    end
                    if (Frame(f).SmoothSkel) 
                        sk = Frame(f).SmoothSkel((end-19):end,1:3);
                        %sk(:,3) = 0; %get 2d projection
                        outputFile = fullfile(dataDir, AlgEvent(i).Name, View(j).Name, Sequence(s).Name, ['frame_', num2str(Frame(f).Index), '_smooth_skeleton.png']);
                        addpath('utils');
                        saveSkeletonImage(sk, outputFile);
                        rmpath('utils');
                    else
                        disp(['###WARNING### Frame ', num2str(f), 'has empty smoothed skeleton']);
                    end
                end
            end
            if (createdSequenceResultsFile)
                fclose(sequenceResultsFileId);
            end
            FN = FN + tm;
            %%%%% parse the video sequence
            if (tm > 5)
                
                disp(['I am parsing the sequence ',AlgEvent(i).Name,' \ ',View(j).Name,' \ ',Sequence(s).Name,' !']);
                parsetrees = Fmain_parsesequence(Xm,Ym,grammar,100);
                SmpN(i) = SmpN(i) + 1;
                tree = parsetrees(1).trees;
                disp(['    Top parse tree ', tree.root])
                
                if strcmp(tree.root,event_name{i})
                    PosN(i) =  PosN(i) + 1;
                end
                
                for cm = 1:size(event_name, 2)
                    if strcmp(tree.root,event_name{cm})
                        ConMat(i,cm) =  ConMat(i,cm) + 1;
                    end
                end
                disp(['I have finished the sequence, parsed "', tree.root, '"']);
            end
        end
        disp(['I have finished the sequences ',AlgEvent(i).Name,'_',View(j).Name,' !']);
    end
end

disp(['I have finished all the sequences!']);
rate = PosN./SmpN
save(outputFile,'PosN','SmpN','rate','ConMat');
%parsetrees.trees

ElapsedTime = toc
spd = (ElapsedTime-ReadTime)/FN
end