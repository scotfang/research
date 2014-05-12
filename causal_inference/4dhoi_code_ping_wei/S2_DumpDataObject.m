function Event = S2_DumpDataObject(eventsPath, dumpFile)
% Read the raw sequence data from SkeletonViewer.exe and dump them to a 
% .mat file.

Frame = struct('Index',{},'Skeleton',{});
Sequence = struct('Name',{},'FNo',{},'Frame',{}); %FNo is number of Frames
View = struct('Name',{},'SNo',{},'Sequence',{}); %SNo is number of samples
Event = struct('Name',{},'VNo',{},'View',{}); %VNo is number of Views

addpath('utils');
event_dirs = getDirs(eventsPath); 
rmpath('utils');

for i = 1:size(event_dirs,1)
    
    Event(i).Name = event_dirs(i).name;
    view_dirs = dir(fullfile(eventsPath, event_dirs(i).name, 'view*'));
    view_dirs = view_dirs(3:end);
    Event(i).VNo = size(view_dirs,1);
    View(:) = [];
    
    for j = 1:size(view_dirs,1)
        View(j).Name = view_dirs(j).name;
        addpath('utils');
        smp_dirs = getDirs(...
            fullfile(eventsPath, event_dirs(i).name, view_dirs(j).name) );
        rmpath('utils');
        View(j).SNo = size(smp_dirs,1);
        
        Sequence(:) = []
        for s = 1:size(smp_dirs,1)
            
            Sequence(s).Name = smp_dirs(s).name;
            sequence.path = fullfile(eventsPath, event_dirs(i).name,...
                view_dirs(j).name, smp_dirs(s).name);
            rgb_str = dir(fullfile(sequence.path,'*_rgb.jpg'));
            sequence.frm_count = size(rgb_str,1);
            Sequence(s).FNo = size(rgb_str,1);
            
            disp(['Extracting ', num2str(size(rgb_str,1)), ...
                ' frames from ', sequence.path])
            Frame(:) = [];
            tic;
            for f = 1:size(rgb_str,1)
                
                tfName = rgb_str(f).name;
                i_d = findstr(tfName, '_');
                frame.index = str2num(tfName((i_d(1)+1):(i_d(2)-1)));
                
                Frame(f).Index = tfName((i_d(1)+1):(i_d(2)-1));
                skel_dir = dir( fullfile(sequence.path, ...
                    ['frame_', num2str(frame.index), '_', '*skeletons.txt']));
                            
                
                Frame(f).Skeleton = [];
                for skelFile = 1:size(skel_dir)
                    disp(['Reading ', skel_dir(skelFile).name]);
                    skelFileName = skel_dir(skelFile).name;
                    tskel = Ftxtread(fullfile(sequence.path, skelFileName)); 
                    if ~isempty(tskel)
                        sk = tskel((end-19):end,1:3);
                        Frame(f).Skeleton = [Frame(f).Skeleton; sk];
                                           
                        %outputFile = fullfile(sequence.path, ...
                            %strrep(skelFileName, 'skeletons.txt', 'raw_skeleton.png'));
                        %outputFile = regexprep(outputFile, 'tc_[0-9]+_', '');
                        
                        %addpath('utils');
                        %saveSkeletonImage(sk, outputFile); 
                        %rmpath('utils')
                        
                    end
                end
            end
            Sequence(s).Frame = Frame;
            disp(['Finished processing (', num2str(toc), ' seconds)'])
        end
        View(j).Sequence = Sequence;
    end
    Event(i).View = View;
end
save(dumpFile,'Event');
disp(['####Dumped events from "', eventsPath, '" to "', dumpFile, '"####']);

end
