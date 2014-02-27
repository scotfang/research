%%%%% S1_MeanSkeleton.m
%%%%% compute the mean of all skeletons, which is used for alignment. 
clear
clc
close all
tic

sum_skels = zeros(20,3);
skels_count = 0;

data_path = 'D:/Program Files/MATLAB/R2011a/work/Data/4D_ActionDataset/';
event_folder = dir(data_path);
event_folder = event_folder(3:end);
for i = 1:size(event_folder,1)
    view_folder = dir([data_path,event_folder(i).name]);
    view_folder = view_folder(3:end);
    for j = 1:size(view_folder,1)
        seq_folder = dir([data_path,event_folder(i).name,'/',view_folder(j).name]);
        seq_folder = seq_folder(3:end);
        for k = 1:size(seq_folder,1)
            seq_path = [data_path,event_folder(i).name,'/',view_folder(j).name,'/',seq_folder(k).name];
            frm_names = dir([seq_path,'/*.txt']);
            disp([event_folder(i).name,'_',view_folder(j).name,'_',seq_folder(k).name]);
            for f = 1:size(frm_names,1)
                skel = Ftxtread([seq_path,'/',frm_names(f).name]);
                if (~isempty(skel))
                    skels_count = skels_count + 1;
                    sum_skels = sum_skels + skel((end-19):end,1:3);                    
                end
            end
        end
    end
end
meanskel = sum_skels/skels_count;
save('D:/Program Files/MATLAB/R2011a/work/4DHOI/parameter/meanskel.mat','meanskel');
Fplot3Dskel(meanskel,0);
toc