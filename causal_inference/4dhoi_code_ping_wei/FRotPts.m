function RotPts = FRotPts(Pts,RotPara)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% rotate the 3D pionts to make the orginal direction OrgDir and
%%%%% reference direction RefDir be in the same direction
%%%%% Pts: M*3, M is the number of points
%%%%% RotPts: M*3, the rotated 3D points
%%%%% t2r: traslation vector from OrgDir to RefDir
%%%%% r2o: traslation vector from RefDir to the zero points
%%%%% Ry: rotation matrix around y axis

% tPts = Pts + repmat(t2r,size(Pts,1),1);
% oPts = tPts + repmat(r2o,size(tPts,1),1);
if ~isempty(Pts)
    tpara = RotPara.t2r+RotPara.r2o;
    oPts = Pts + repmat(tpara,size(Pts,1),1);
    rPts = oPts*RotPara.Ry;
    RotPts = rPts - repmat(RotPara.r2o,size(rPts,1),1);
else
    RotPts = [];
end