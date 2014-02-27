%%%%% Generate the action grammar 
clear,clc,tic
grammar = struct('event',{},'atom',{},'next',{},'mu',{},'sigma',{},'transpara',{},'object',{},'hoi',{},'index',{});
ObjClass = containers.Map({'01_mug','02_phone','03_book','04_mouse','05_keyboard','06_dispenser',...
    '07_kettle','08_button','09_monitor','10_chair','11_desk'},...
    {1,2,3,4,5,6,7,8,9,10,11});
event_name = {'01_drink with mug','02_make a call','03_read book','04_use mouse','05_use keyboard','06_fetch water','07_pour water','08_press button'};
object_name = {{'01_mug'},{'02_phone'},{'03_book'},{'04_mouse','09_monitor','10_chair','11_desk'},{'05_keyboard','09_monitor','10_chair','11_desk'},{'01_mug','06_dispenser'},{'01_mug','07_kettle'},{'08_button'}};

empara_path = 'parameter\EMParas\';
transpara_path = 'parameter\Sigmoid\';
hoipara_path = 'parameter\HOIParas\';
trackpara_path = 'parameter\TrackPara\';
empara_file = dir([empara_path,'*.mat']);
trans_file = dir([transpara_path,'*.mat']);
hoipara_file = dir([hoipara_path,'*_hoipara.mat']);
trckpara_file = dir([trackpara_path,'*_trackpara.mat']);

rn = 0;
for i = 1:size(event_name,2)
    load([empara_path,empara_file(i).name]);
    load([transpara_path,trans_file(i).name]); 
    load([hoipara_path,hoipara_file(i).name]);
    load([trackpara_path,trckpara_file(i).name]);
    for j = 1:size(Mu,2)
        rn = rn + 1;
        grammar(rn).event = event_name{i};
        grammar(rn).atom = [event_name{i},'_',num2str(j)];
        grammar(rn).mu = Mu(:,j);
        grammar(rn).sigma = Sigma(:,:,j);
        grammar(rn).transpara = SIGM(:,j);
        hoi = HOI{j};
        trck = Track{j};
        
        if j < size(Mu,2)
            grammar(rn).next = [event_name{i},'_',num2str(j+1)];
        else
            grammar(rn).next = [];
        end
        for oi = 1:size(object_name{i},2)
            obj_id = ObjClass(object_name{i}{oi});
            grammar(rn).object{oi} = object_name{i}{oi};
            grammar(rn).hoi{oi}.mu = hoi(oi).mu;
            grammar(rn).hoi{oi}.sigma = hoi(oi).sigma;
            if ismember(obj_id,[4 5 6 8 9 10 11])
                grammar(rn).trck{oi}.mu = [];
                grammar(rn).trck{oi}.sigma = [];
                object_name{i}{oi}
            else
                grammar(rn).trck{oi}.mu = trck(oi).mu;
                grammar(rn).trck{oi}.sigma = trck(oi).sigma;
            end

%             hoi(oi).sigma
%             DETSIGMA = det(hoi(oi).sigma)
        end
        grammar(rn).index = rn;
    end    
end

save('parameter\grammar.mat','grammar');
toc