%%%%% S3_Pre_Align_Smooth_Motion
%%%%% Align the data to the mean skeleton, smooth the data with frames
%%%%% before and after, and compute the motion vector of each frame.
clear,clc,tic

load('parameter\meanskel.mat');    %%% load mean skeleton
load('parameter\Event.mat');       %%% load all skeleton
anc = {[2,5,9],[2,3,5],[2,3,9]};   %%% anchor point, whole body, left arm, right arm

for i = 1:size(Event,2)
    AlgEvent(i).Name = Event(i).Name;
    AlgEvent(i).VNo = Event(i).VNo;
    
    View = Event(i).View; 
    clear AlgView
    for j = 1:Event(i).VNo
        AlgView(j).Name = View(j).Name;
        AlgView(j).SNo = View(j).SNo;
        
        Sequence = View(j).Sequence;
        clear AlgSequence
        for s = 1:View(j).SNo
            AlgSequence(s).Name = Sequence(s).Name;
            AlgSequence(s).FNo = Sequence(s).FNo;
            
            Frame = Sequence(s).Frame;
            
            %%%%% align the skeletons
            clear AlgFrame
            for f = 1:Sequence(s).FNo
                AlgFrame(f).Index = Frame(f).Index;
                
                if (isempty(Frame(f).Skeleton))
                    AlgFrame(f).AlgSkel = [];
                    AlgFrame(f).AlgArms = [];
                end
                if (~isempty(Frame(f).Skeleton))
                    rawskel = Frame(f).Skeleton;
                    tskel = rawskel(:,1:3);
                    if size(tskel,1)== 20
                        %%% whole body alignment, anchor points [2,5,9]
                        [param_w, ~, ~, ~, sof_w] = helmert3d(tskel(anc{1},:),meanskel(anc{1},:),'7p');
                        if (sof_w == 0)
                            AlgFrame(f).AlgSkel = [];
                        else
                            AlgFrame(f).AlgSkel = d3trafo(tskel,param_w,[],0);                            
                        end
                        %%% left arm and right arm, anchor points [2,3,5],[2,3,9]
                        arms = zeros(6,3);
                        [param_l, ~, ~, ~, sof_l] = helmert3d(tskel(anc{2},:),meanskel(anc{2},:),'7p');
                        [param_r, ~, ~, ~, sof_r] = helmert3d(tskel(anc{3},:),meanskel(anc{3},:),'7p');
                        if (sof_l==0)|(sof_r==0)
                            AlgFrame(f).AlgArms = [];
                        else
                            larm =  d3trafo(tskel([5,6,7,8],:),param_l,[],0);
                            rarm =  d3trafo(tskel([9,10,11,12],:),param_r,[],0);
                            dlarm = meanskel(5,:)-larm(1,:);
                            arms(1:3,:) = larm(2:4,:)+repmat(dlarm,3,1);
                            drarm = meanskel(9,:)-rarm(1,:);
                            arms(4:6,:) = rarm(2:4,:)+repmat(drarm,3,1);
                            AlgFrame(f).AlgArms = arms;
                        end
                    else
                        AlgFrame(f).AlgSkel = [];
                        AlgFrame(f).AlgArms = [];                        
                    end
                end                               
            end  
            disp(['Action_',Event(i).Name,'_View_',View(j).Name,'_Sequence_',Sequence(s).Name,'......Aligned','_TOC_',num2str(toc)]);
            
            %%%%% smooth the skeletons
            for f = 1:Sequence(s).FNo
                %%% smooth whole body skeleton
                if (~isempty(AlgFrame(f).AlgSkel))
                    if (f>1)&(f<Sequence(s).FNo) 
                        if (~isempty(AlgFrame(f-1).AlgSkel))&(~isempty(AlgFrame(f+1).AlgSkel))
                            AlgFrame(f).SmoothSkel = (AlgFrame(f-1).AlgSkel+AlgFrame(f).AlgSkel+AlgFrame(f+1).AlgSkel)/3;
                        else 
                            AlgFrame(f).SmoothSkel = AlgFrame(f).AlgSkel;
                        end
                    elseif f == 1
                        if (~isempty(AlgFrame(2).AlgSkel))
                            AlgFrame(f).SmoothSkel = (AlgFrame(1).AlgSkel+AlgFrame(2).AlgSkel)/2;
                        else
                            AlgFrame(f).SmoothSkel = AlgFrame(1).AlgSkel;
                        end
                    else
                        if (~isempty(AlgFrame(f-1).AlgSkel))
                            AlgFrame(f).SmoothSkel = (AlgFrame(f-1).AlgSkel+AlgFrame(f).AlgSkel)/2;
                        else
                            AlgFrame(f).SmoothSkel = AlgFrame(f).AlgSkel;
                        end                        
                    end                    
                else
                    AlgFrame(f).SmoothSkel = [];
                end
                
                %%% smooth arms
                if (~isempty(AlgFrame(f).AlgArms))
                    if (f>1)&(f<Sequence(s).FNo)
                        if (~isempty(AlgFrame(f-1).AlgArms))&(~isempty(AlgFrame(f+1).AlgArms))
                            AlgFrame(f).SmoothArms = (AlgFrame(f-1).AlgArms+AlgFrame(f).AlgArms+AlgFrame(f+1).AlgArms)/3;
                        else
                            AlgFrame(f).SmoothArms = AlgFrame(f).AlgArms;
                        end
                    elseif f == 1
                        if (~isempty(AlgFrame(2).AlgArms))
                            AlgFrame(f).SmoothArms = (AlgFrame(1).AlgArms+AlgFrame(2).AlgArms)/2;
                        else
                            AlgFrame(f).SmoothArms = AlgFrame(1).AlgArms;
                        end
                    else
                        if (~isempty(AlgFrame(f-1).AlgArms))
                            AlgFrame(f).SmoothArms = (AlgFrame(f-1).AlgArms+AlgFrame(f).AlgArms)/2;
                        else
                            AlgFrame(f).SmoothArms = AlgFrame(f).AlgArms;
                        end
                    end
                else
                    AlgFrame(f).SmoothArms = [];
                end
                                               
            end  
            disp(['Action_',Event(i).Name,'_View_',View(j).Name,'_Sequence_',Sequence(s).Name,'......Smoothed','_TOC_',num2str(toc)]);
            
            %%%%% compute the motion vector
            for f = 1:Sequence(s).FNo
                %%% whole body skeleton motion
                if (~isempty(AlgFrame(f).SmoothSkel))
                    if f ~= 1
                       if (~isempty(AlgFrame(f-1).SmoothSkel))
                          AlgFrame(f).MotionSkel = AlgFrame(f).SmoothSkel-AlgFrame(f-1).SmoothSkel; 
                       else
                          AlgFrame(f).MotionSkel = 0*AlgFrame(f).SmoothSkel;
                       end
                    else
                       AlgFrame(f).MotionSkel = 0*AlgFrame(f).SmoothSkel; 
                    end                  
                else
                    AlgFrame(f).MotionSkel = [];
                end
                
                %%% arms motion
                if (~isempty(AlgFrame(f).SmoothArms))
                    if f ~= 1
                        if (~isempty(AlgFrame(f-1).SmoothArms))
                            AlgFrame(f).MotionArms = AlgFrame(f).SmoothArms-AlgFrame(f-1).SmoothArms;
                        else
                            AlgFrame(f).MotionArms = 0*AlgFrame(f).SmoothArms;
                        end
                    else
                        AlgFrame(f).MotionArms = 0*AlgFrame(f).SmoothArms;
                    end
                    
                else
                    AlgFrame(f).MotionArms = [];
                end                                               
            end 
            AlgFrame(1).MotionSkel = AlgFrame(2).MotionSkel;
            AlgFrame(1).MotionArms = AlgFrame(2).MotionArms;
            disp(['Action_',Event(i).Name,'_View_',View(j).Name,'_Sequence_',Sequence(s).Name,'......Motioned','_TOC_',num2str(toc)]);
            AlgSequence(s).Frame = AlgFrame;
        end
        AlgView(j).Sequence = AlgSequence;
    end
    AlgEvent(i).View = AlgView;
end

save('parameter\AlgEvent.mat','AlgEvent');

ElapsedTime = toc