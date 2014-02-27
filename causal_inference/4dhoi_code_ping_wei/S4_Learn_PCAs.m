%%%%%S4_Learn_PCAs.m
%%%%% Learn the principal components of each event category 
%%%%% Learn PCAs for all the data not for each event category.
%%%%% revised by Ping Wei, Nov 03, 2012
%%%%% revised by Ping Wei, Sep 03, 2013

clear,clc,tic 

load('parameter\meanskel.mat');    %%% load mean skeleton
load('parameter\AlgEvent.mat');    %%% load all skeleton

X = [];
for i = 1:size(AlgEvent,2)
    
    View = AlgEvent(i).View;
    for j = 1:AlgEvent(i).VNo
        
        Sequence = View(j).Sequence;
        for s = 1:View(j).SNo
            
            Frame = Sequence(s).Frame;
            Xm = []; % The frame array of each sequence
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
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data from arms
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    Xm(:,tm) = frm;
                end
            end
            if (~isempty(Xm))
                X = [X;Xm'];
            end
            disp(['Action_',AlgEvent(i).Name,'_View_',View(j).Name,'_Sequence_',Sequence(s).Name,'_TOC_',num2str(toc)]);
        end
    end
end

disp('I am running the PCs of all the events !');
disp('...... ...... ...... ...... ...... ...... ...... ......');
[sX,PCA_Mu,PCA_Sigma] = zscore(X);
[PCA_Coeff,Score,PCA_Eigv] = princomp(sX);
save('parameter\PCA_Paras.mat','PCA_Mu','PCA_Sigma','PCA_Coeff','PCA_Eigv');
disp('...... ...... ...... ......');
disp('I have finished learning the PCs of all the events !!!');

ElapsedTime = toc