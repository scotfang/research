%%%%% Fframe_index.m

function fmid = Fframe_index(pathstr)

i_d = findstr(pathstr, '\');
fmid = str2num(pathstr((i_d(end)+1):end));
