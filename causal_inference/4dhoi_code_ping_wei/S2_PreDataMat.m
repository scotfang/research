%%%%% S2_PreDataMat.m
%%%%% read the sequence data and save them in a .mat file
clear,clc,tic

Frame = struct('Index',[],'Skeleton',[]);
Sequence = struct('Name',[],'FNo',[],'Frame',[]);
View = struct('Name',[],'SNo',[],'Sequence',[]);
Event = struct('Name',[],'VNo',[],'View',[]);

events_path = 'D:/Program Files/MATLAB/R2011a/work/Data/4D_ActionDataset';
events_folder = dir(events_path);
events_folder = events_folder(3:end);

for i = 1:size(events_folder,1)
    
    Event(i).Name = events_folder(i).name;
    view_folder = dir([events_path,'\',events_folder(i).name]);
    view_folder = view_folder(3:end);
    Event(i).VNo = size(view_folder,1);
    clear View
    
    for j = 1:size(view_folder,1)
        View(j).Name = view_folder(j).name;
        smp_folder = dir([events_path,'\',events_folder(i).name,'\',view_folder(j).name]);
        smp_folder = smp_folder(3:end);
        View(j).SNo = size(smp_folder,1);
        
        clear Sequence
        for s = 1:size(smp_folder,1)
            
            Sequence(s).Name = smp_folder(s).name;
            sequence.path = [events_path,'\',events_folder(i).name,'\',view_folder(j).name,'\',smp_folder(s).name];
            rgb_str = dir([sequence.path,'\*_rgb.jpg']);
            sequence.frm_count = size(rgb_str,1);
            Sequence(s).FNo = size(rgb_str,1);
            
            clear Frame
            for f = 1:size(rgb_str,1)
                
                tfname = rgb_str(f).name;
                i_d = findstr(tfname, '_');
                frame.index = str2num(tfname((i_d(1)+1):(i_d(2)-1)));
                
                Frame(f).Index = tfname((i_d(1)+1):(i_d(2)-1));
                skel_dir = dir([sequence.path,'\frame_',num2string(frame.index,7),'*_skeletons.txt']);
                
                if(isempty(skel_dir))
                    Frame(f).Skeleton = [];
                else
                    tskel = Ftxtread([sequence.path,'\',skel_dir(1).name]);
                    if ~isempty(tskel)
                        Frame(f).Skeleton = tskel((end-19):end,1:3);
                    else
                        Frame(f).Skeleton = [];
                    end
                end
            end
            Sequence(s).Frame = Frame;
            disp(['Action_',Event(i).Name,'_View_',view_folder(j).name,'_Sequence_',Sequence(s).Name,'_TOC_',num2str(toc)]);
        end
        View(j).Sequence = Sequence;
    end
    Event(i).View = View;
end

save(['D:\Program Files\MATLAB\R2011a\work\4DHOI\parameter\Event.mat'],'Event');

toc