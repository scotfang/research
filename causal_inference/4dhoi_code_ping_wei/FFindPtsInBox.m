%%%%% FFindPtsInBox(Pts,Box)
function [InPts,InIndex] = FFindPtsInBox(Pts,Box)


xmin = Box(1,1);
xmax = Box(2,1);
ymin = Box(1,2);
ymax = Box(2,2);
zmin = Box(1,3);
zmax = Box(2,3);
InIndex = find(Pts(:,1) <= xmax & Pts(:,1) >= xmin & Pts(:,2) <= ymax & Pts(:,2) >= ymin &Pts(:,3) <= zmax & Pts(:,3) >= zmin);

% xmin = min(Box(:,1));
% xmax = max(Box(:,1));
% ymin = min(Box(:,2));
% ymax = max(Box(:,2));
% zmin = min(Box(:,3));
% zmax = max(Box(:,3));
% xInd = find(Pts(:,1) <= xmax & Pts(:,1) >= xmin);
% yInd = find(Pts(:,2) <= ymax & Pts(:,2) >= ymin);
% zInd = find(Pts(:,3) <= zmax & Pts(:,3) >= zmin);
% a = intersect(xInd,yInd);
% InIndex = intersect(a,zInd);

InPts = Pts(InIndex,:);