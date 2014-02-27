%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel_spc_pts = Fdeps2skls(depth_spc_pts)
% Descripton: transform the coordinates in skeleton space to depth space
% Input: 
%    depth_spc_pts: N*3, i,j,depth value, image coordinate, 0.0 to 1.0. i
%    is the vertical coordinate, and j is the horizontal coordinate
% Output:
%    skel_spc_pts: N*3, x,y,z in skeleton space.
%      x: –2.2 to 2.2
%      y: –2.2 to 2.2
%      z:  0.0 to 4.0
% By Ping Wei, 08-21-2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xyz = Fdeps2skls(ijd)

xyz = zeros(size(ijd,1),3);
ijd = double(ijd);
xyz(:,3) = double(ijd(:,3))./1000;
xyz(:,1) = (ijd(:,2)- 0.5).*xyz(:,3)*1.12032;
xyz(:,2) = (0.55-ijd(:,1)).*xyz(:,3)*0.84024;

% %  xyz(:,1) = (ijd(:,2) - 0.5302).*xyz(:,3)*1.0771;
% %  xyz(:,2) = (0.5057 - ijd(:,1)).*xyz(:,3)*0.8121;