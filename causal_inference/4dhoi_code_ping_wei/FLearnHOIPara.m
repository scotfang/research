function HOI = FLearnHOIPara(S,Y,EI)

if size(S,1) ~= size(Y,1)
   error('myApp:lrnPara','The sizes of S and Y are not the same!!!');
end

HOIObj = {{'01_mug'},{'02_phone'},{'03_book'},{'04_mouse','09_monitor','10_chair','11_desk'},...
    {'05_keyboard','09_monitor','10_chair','11_desk'},{'01_mug','06_dispenser'},...
    {'01_mug','07_kettle'},{'08_button'}};
ObjClassMap = containers.Map({'01_mug','02_phone','03_book','04_mouse','05_keyboard','06_dispenser',...
    '07_kettle','08_button','09_monitor','10_chair','11_desk'},...
    {1,2,3,4,5,6,7,8,9,10,11});
HOI = [];
hoi_obj = HOIObj{EI};

HODiff = cell(size(HOIObj{EI},2),(size(S,2)-1));
%MhtPara = struct('Q',{},'Nm',{},'Ct',{});
load('parameter\rot_ref_skel.mat');
for i = 1:size(Y,1)
    SY = Y{i};
    SS = S(i,:);
    
    MhtPara.Q = [];
    MhtPara.Nm = [];
    MhtPara.Ct = [];
    di = 0;
    while isempty(MhtPara.Q)
        di = di + 1;
        if di > 3
            break;
        end
        pathstr = SY{di}(1:(end-13));
        depth_name = dir([SY{di},'*_depth.png']);
        depth_img = imread([pathstr,'/',depth_name(1).name]);
        depth_img = fliplr(depth_img);
        depth_smooth =  FMultiMedfilter(depth_img,2,[3 3]);
        MhtPara =  FGetManhattanAxis(depth_smooth);
    end
    if isempty(MhtPara.Q)
       continue;
    end    
    
    skel_name = dir([SY{di},'*.txt']);
    tskel = Ftxtread([SY{di}(1:(end-13)),'/',skel_name(1).name]);
    skel = tskel((end-19):end,1:3);
    skel = FFlipPts(skel);
    mht_skel = FManhattanPts(skel,MhtPara.Q,MhtPara.Ct);
    [~,RotPara] = FRotScenePts(mht_skel,mht_skel([5,9],:),rot_ref_skel([5,9],:));
    %RotSkel = FRotPts(MhtSkel,RotPara);
    %disp(pathstr);
    %disp(num2str(i))
        
    for c = 1:(size(SS,2)-1)
        for ci = SS(c):(SS(c+1)-1)
            
            pathstr = SY{ci}(1:(end-13));           
            
            skel_name = dir([SY{ci},'*.txt']);
            tskel = Ftxtread([pathstr,'/',skel_name(1).name]);
            skel = tskel((end-19):end,1:3);
            skel = FFlipPts(skel);
            MhtSkel = FManhattanPts(skel,MhtPara.Q,MhtPara.Ct);
            MhtSkel = FRotPts(MhtSkel,RotPara);
            
            depth_name = dir([SY{ci},'*_depth.png']);
            depth_img = imread([pathstr,'/',depth_name(1).name]);
            depth_img = fliplr(depth_img);
            depth_smooth =  FMultiMedfilter(depth_img,2,[3 3]);
            
            maprgbd_name = dir([SY{ci},'*_maprgbd.png']);
            maprgbd_img = imread([pathstr,'/',maprgbd_name(1).name]);
            
            for oi = 1:size(hoi_obj,2)
                %disp(['ci_',num2str(ci),'_oi_',num2str(oi)])
                objname = ['0',hoi_obj{oi}];
                
                limgstr = dir([SY{ci},'_',objname,'_label.png']);
                
                if ~isempty(limgstr)
                    label_img = imread([SY{ci},'_',objname,'_label.png']);
                    if length(find(label_img==1))/307200 < 0.5
                        pts_rgb = FPtLabelRgb(label_img);
                        %tic
                        pts_depth = FrgbINdepth(pts_rgb, maprgbd_img);
                        pts_depth(:,2) = 321-pts_depth(:,2);
                        %ElapsedTime = toc
                        ijd = [pts_depth(:,1)./240,pts_depth(:,2)./320,double(diag(depth_smooth(pts_depth(:,1),pts_depth(:,2))))];
                        txyz = Fdeps2skls(ijd);
                        xyz = FRemoveNoisePts(double(txyz));
                        if ~isempty(xyz)
                            xyz_mht = FManhattanPts(xyz,MhtPara.Q,MhtPara.Ct);
                            ObjBc = mean(xyz_mht);                            
                            ObjBc = FRotPts(MhtSkel,RotPara);
                            ObjInd = ObjClassMap(hoi_obj{oi});
                            hodiff = FHODiff(MhtSkel,ObjBc,ObjInd);
                            HODiff{oi,c} = [HODiff{oi,c};hodiff];
                        end
                    end
                end
            end
        end
    end 
    OneSequenceTime = toc
end

for j = 1:size(HODiff,2)
    hoi = [];
    for i = 1:size(HODiff,1)
        %disp([num2str(j),'_',num2str(i)]);
        if ~isempty(HODiff{i,j})
            hoi(i).mu = mean(HODiff{i,j});
            X = HODiff{i,j} - repmat(hoi(i).mu,size(HODiff{i,j},1),1);
            hoi(i).sigma = (X'*X)./(size(X,1)-1);
        else
            hoi(i).mu = [];
            hoi(i).sigma = [];
        end
    end
    HOI{j} = hoi;    
end