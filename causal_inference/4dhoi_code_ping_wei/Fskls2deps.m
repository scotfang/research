%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [I,J,D] = Fskls2deps(X,Y,Z)
% Descripton: transform the coordinates in skeleton space to depth space
% Input: 
%    xyz: N*3, x,y,z in skeleton space.
%      x: –2.2 to 2.2
%      y: –2.2 to 2.2
%      z:  0.0 to 4.0
% Output:
%      ijd: N*3, i,j,depth value, image coordinate, 0.0 to 1.0,
%      i is the vertical coordinate, and j is the horizontal coordinate    
% By Ping Wei, 08-21-2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ijd = Fskls2deps(xyz)

epsl = 0.000001;
z = xyz(:,3);
zeroind = find(z==0);
if(~isempty(zeroind))
   z(zeroind) = epsl;
end
ijd(:,3) = (z)*1000;

ijd(:,1) = min(240,floor(240*(0.55 - xyz(:,2)./(xyz(:,3)*0.84024))));
ijd(:,2) = min(320,floor(320*(0.5 + xyz(:,1)./(xyz(:,3)*1.12032))));


% ijd(:,1) = 0.5057 - xyz(:,2)./(xyz(:,3)*0.8121);
% ijd(:,2) = 0.5302 + xyz(:,1)./(xyz(:,3)*1.0771);

