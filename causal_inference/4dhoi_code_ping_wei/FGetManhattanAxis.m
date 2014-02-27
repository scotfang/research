%%%%% Compute the Manhattan Axis parameters to calibrate the scene
function MhtPara =  FGetManhattanAxis(Depth)

DepthSmooth =  FMultiMedfilter(Depth,2,[3 3]);

[row,col]=size(Depth);
x=1:col;
y=1:row;
[y_d x_d]=ndgrid(y,x);
x_d=x_d(:);
y_d=y_d(:);
IJD = [y_d./240,x_d./320,DepthSmooth(:)];
XYZ = Fdeps2skls(IJD);
XYZ = FRemoveZeroPts(XYZ);
[Q, Pts, Nm, Ct]=getManhattanAxis(XYZ);
MhtPara.Q = Q;
MhtPara.Pts = Pts;
MhtPara.Nm = Nm;
MhtPara.Ct = Ct;

% clrdata = 1*ones(size(XYZ,1),1);
% Fplot3k(XYZ,clr,'colordata',clrdata,'Marker',{'.',2}); hold on

