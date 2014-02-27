function [RotPts,RotPara] = FRotScenePts(Pts,OrgDir,RefDir)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% rotate the 3D pionts to make the orginal direction OrgDir and
%%%%% reference direction RefDir be in the same direction
%%%%% Pts: M*3, M is the number of points
%%%%% OrgDir: 2*3, the start point and end point of the vector
%%%%% RefDir: 2*3, the start point and end point of the vector
%%%%% RotPts: M*3, the rotated 3D points
%%%%% t2r: traslation vector from OrgDir to RefDir
%%%%% r2o: traslation vector from RefDir to the zero points
%%%%% Ry: rotation matrix around y axis

t2r = RefDir(1,:) - OrgDir(1,:);
tOrgDir = OrgDir + repmat(t2r,size(OrgDir,1),1);
tPts = Pts + repmat(t2r,size(Pts,1),1);

a = (tOrgDir(2,[3,1])-tOrgDir(1,[3,1]));
b = (RefDir(2,[3,1])-RefDir(1,[3,1]));
angle1 = atan2(a(2), a(1));
angle2 = atan2(b(2), b(1));
angler = angle2 - angle1;
cosa = cos(angler);
sina = sin(angler);

r2o = -RefDir(1,:);
oPts = tPts + repmat(r2o,size(tPts,1),1);
Ry = [cosa 0  -sina
      0    1  0
      sina 0  cosa];
rPts = oPts*Ry;
RotPts = rPts - repmat(r2o,size(rPts,1),1);

RotPara.t2r = t2r;
RotPara.r2o = r2o;
RotPara.Ry = Ry;

% if norm(a)~= 0 & norm(b)~= 0
%     cosa = (a*b')/(norm(a)*norm(b));
% else
%     RotPts = Pts;
%     return;
% end
% sina = -sqrt(1-cosa^2);
% 
% r2o = -RefDir(1,:);
% oPts = tPts + repmat(r2o,size(tPts,1),1);
% Ry = [cosa 0  -sina
%       0    1  0
%       sina 0  cosa];
% rPts = oPts*Ry;
% RotPts = rPts - repmat(r2o,size(rPts,1),1);


% angle1 = atan2(a(2), a(1));   
% angle2 = atan2(b(2), b(1));   
% angler = angle2 - angle1; 