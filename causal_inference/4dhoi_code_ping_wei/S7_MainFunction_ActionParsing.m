%%%%% S8_MainFunction_ActionParsing.m
%%%%% 
clear,clc,tic 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% data struct definition
tree = struct('root',{},'atom',{},'index',{},'frameindex',{},'energy',{});
parsetrees = struct('tree',{},'segment',{},'frameseg',{},'tenergy',{});
event_name = {'01_drink with mug','02_make a call',...
    '03_read book','04_use mouse','05_use keyboard',...
    '06_fetch water','07_pour water','08_press button'};
load('parameter\grammar.mat');
load('parameter\AlgEvent.mat');    %%% load all skeleton
load('parameter\PCA_Paras.mat');   %%% load PCA parameters
ReadTime = tic
TRR = 1/3;                         %%% the ratio of training samples
PCN = 20;                          %%% PC number

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% parse each event sequence and output the tree structure
SmpN = zeros(8,1);
PosN = zeros(8,1);
ConMat = zeros(8,8);
FN = 0;

for i = 1:size(AlgEvent,2)
    
    View = AlgEvent(i).View;
    for j = 1:AlgEvent(i).VNo
        
        Sequence = View(j).Sequence;
        ASI = 1:View(j).SNo;         %%% all sample indexes
        TRI = 1:(1/TRR):View(j).SNo; %%% training sample indexes
        TEI = setdiff(ASI,TRI);      %%% testing sample indexes
        
        for s = TEI
            
            Frame = Sequence(s).Frame;
            Xm = []; % The frame array of each sequence
            Ym = [];
            tm = 0;  % The frame number of Xm
            
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
                end
            end
            FN = FN + tm;
            %%%%% parse the video sequence
            if (tm > 5)
                %disp(['I am parsing the sequence ',AlgEvent(i).Name,' \ ',View(j).Name,' \ ',Sequence(s).Name,' !']);
                parsetrees = Fmain_parsesequence(Xm,Ym,grammar,100);
                SmpN(i) = SmpN(i) + 1;
                tree = parsetrees(1).trees;
                
                if strcmp(tree.root,event_name{i})
                    PosN(i) =  PosN(i) + 1;
                end
                
                for cm = 1:8
                    if strcmp(tree.root,event_name{cm})
                        ConMat(i,cm) =  ConMat(i,cm) + 1;
                    end
                end
                %disp(['I have finished the sequence ',AlgEvent(i).Name,' \ ',View(j).Name,' \ ',Sequence(s).Name,' !']);
            end
        end
        disp(['I have finished the sequences ',AlgEvent(i).Name,'_',View(j).Name,' !']);
    end
end

disp(['I have finished all the sequences!']);
rate = PosN./SmpN
save('parameter\Results\action_parsing_res.mat','PosN','SmpN','rate','ConMat');
%parsetrees.trees

ElapsedTime = toc
spd = (ElapsedTime-ReadTime)/FN