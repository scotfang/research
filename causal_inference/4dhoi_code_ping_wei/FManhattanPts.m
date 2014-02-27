function MhtPts = FManhattanPts(pts,Q,center)

tt2=[pts(:,1)-center(1) pts(:,2)-center(2) pts(:,3)-center(3)]*Q;
MhtPts=[tt2(:,1)+center(1) tt2(:,2)+center(2) tt2(:,3)+center(3)];

