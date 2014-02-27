%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% obox = F3Dobjbox(z);
% Descripton: calculate the 3D bounding box of object given points cloud
% Input: 
% z: 3D coordinates, N*3 dims, N is the number of points
% output: 
% obox: 3D coordinates of vertex of object bounding box, 8*3
% By Ping Wei, 01-27-2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function obox = F3Dobjbox(z)

xmin = min(z(:,1));
xmax = max(z(:,1));
ymin = min(z(:,2));
ymax = max(z(:,2));
zmin = min(z(:,3));
zmax = max(z(:,3));


obox(1,:) = [xmax ymax zmin];
obox(2,:) = [xmin ymax zmin];
obox(3,:) = [xmin ymax zmax];
obox(4,:) = [xmax ymax zmax];
obox(5,:) = [xmax ymin zmin];
obox(6,:) = [xmin ymin zmin];
obox(7,:) = [xmin ymin zmax];
obox(8,:) = [xmax ymin zmax];

