%%%%% S5_LearnAtom_OrderEM
%%%%% Learn the atomic actions with odering EM
%%%%% By Ping Wei, Sep 03, 2013

clear,clc,tic 

load('parameter\meanskel.mat');    %%% load mean skeleton
load('parameter\AlgEvent.mat');    %%% load all skeleton
load('parameter\PCA_Paras.mat');   %%% load PCA parameters
%ECK = [3 3 4 3 3 4 4 3];           %%% event cluster number
ECK = [4 4 4 4 4 4 4 4];           %%% event cluster number
TRR = 1/3;                         %%% the ratio of training samples
PCN = 20;                          %%% PC number
EMParaPath = 'parameter\EMParas\';


for i = [1 2 4 5 6] %1:size(AlgEvent,2)
    
    View = AlgEvent(i).View;
    X = {};
    Y = {};
    for j = 1:AlgEvent(i).VNo
        
        Sequence = View(j).Sequence;        
        TRN = 1:(1/TRR):View(j).SNo;
        for s = TRN     
            
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
            if (~isempty(Xm))
                X{end+1,1} = Xm;
                Y{end+1,1} = Ym;
            end
            disp(['Action_',AlgEvent(i).Name,'_View_',View(j).Name,'_Sequence_',Sequence(s).Name,'_TOC_',num2str(toc)]);
        end
    end
    disp(['I am running with EM to cluster event ',AlgEvent(i).Name,' !']);
    disp('...... ...... ...... ...... ...... ......');
    [W,Mu,Sigma,S,L] = FOrderingEM(X,ECK(i),0.00005,100);
    save([EMParaPath,AlgEvent(i).Name,'_empara.mat'],'W','Mu','Sigma','S','L','Y');
    CurrentElapsetime = toc
    disp('...... ...... ...... ...... ...... ......');
    disp(['I have finished clustering event',AlgEvent(i).Name,'!!!']);
end
ElapsedTime = toc