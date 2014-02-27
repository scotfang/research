%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M = Ftxtread(filepath);
% Descripton: read the text file row by row
% Input:
% filepath: the file path
% Output:
% N:        data number
% M:        data matrix%
% By Ping Wei, 01-07-2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function M = Ftxtread(filepath)

fid = fopen(filepath);                                 % open file
N = fscanf(fid,'%f',[1 1]); 
% read the point number
i = 0;
M = [];
while ~feof(fid)
    tmp = fscanf(fid,['%f' ',']);
    if ~isempty(tmp)
       i = i + 1;
       M(:,i) = tmp;
    end
end
M = M';

fclose(fid); 